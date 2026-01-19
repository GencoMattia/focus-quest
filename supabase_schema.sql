-- Enable Row Level Security
alter table auth.users enable row level security;

-- PROFILES
create table profiles (
  id uuid references auth.users not null primary key,
  username text,
  full_name text,
  avatar_url text,
  updated_at timestamp with time zone
);

alter table profiles enable row level security;

create policy "Users can view their own profile." on profiles
  for select using (auth.uid() = id);

create policy "Users can insert their own profile." on profiles
  for insert with check (auth.uid() = id);

create policy "Users can update their own profile." on profiles
  for update using (auth.uid() = id);

-- TASKS
create table tasks (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users not null,
  title text not null,
  description text,
  estimated_duration integer, -- in minutes
  start_date timestamp with time zone,
  deadline timestamp with time zone,
  urgency text check (urgency in ('low', 'medium', 'high')),
  status text check (status in ('todo', 'in_progress', 'paused', 'completed')) default 'todo',
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

alter table tasks enable row level security;

create policy "Users can all CRUD their own tasks." on tasks
  for all using (auth.uid() = user_id);

-- TASK SESSIONS (For tracking time)
create table task_sessions (
  id uuid default gen_random_uuid() primary key,
  task_id uuid references tasks(id) on delete cascade not null,
  start_time timestamp with time zone default now(),
  end_time timestamp with time zone,
  duration_seconds integer
);

alter table task_sessions enable row level security;

create policy "Users can all CRUD their own sessions." on task_sessions
  for all using (
    exists ( select 1 from tasks where id = task_sessions.task_id and user_id = auth.uid() )
  );

-- EMOTIONAL LOGS
create table emotional_logs (
  id uuid default gen_random_uuid() primary key,
  task_id uuid references tasks(id) on delete cascade,
  user_id uuid references auth.users not null,
  mood text, -- e.g., 'calm', 'anxious', 'energetic'
  note text,
  context text, -- 'pre_task', 'post_task', 'pause'
  created_at timestamp with time zone default now()
);

alter table emotional_logs enable row level security;

create policy "Users can all CRUD their own logs." on emotional_logs
  for all using (auth.uid() = user_id);

-- STORAGE BUCKETS (Images)
insert into storage.buckets (id, name) values ('task_images', 'task_images');

create policy "Any authenticated user can insert images." on storage.objects
  for insert with check ( bucket_id = 'task_images' and auth.role() = 'authenticated' );

create policy "Users can view their own images" on storage.objects
  for select using ( bucket_id = 'task_images' and auth.uid()::text = (storage.foldername(name))[1] );

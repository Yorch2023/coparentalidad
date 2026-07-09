create table solicitudes (
    id bigint generated always as identity primary key,
    tipo text not null,
    tipo_label text not null,
    from_date date not null,
    to_date date,
    motivo text default '',
    estado text not null default 'pendiente' check (estado in ('pendiente','aprobada','rechazada')),
    from_user text not null check (from_user in ('J','E')),
    created_at timestamptz default now(),
    resuelto_en timestamptz
  );

alter table solicitudes enable row level security;

create policy "solicitudes_read" on solicitudes for select to authenticated using (true);

create policy "solicitudes_insert" on solicitudes for insert to authenticated with check (from_user = my_role());

create policy "solicitudes_update" on solicitudes for update to authenticated using (true);

create policy "solicitudes_delete" on solicitudes for delete to authenticated using (from_user = my_role());

Create table if not exists customers (
    id serial primary key,
    first_name varchar(255) not null,
    last_name varchar(255) not null,
    email varchar(255) not null unique,
    created_at timestamp with time zone default now()
);


Create table if not exists account (
    id serial primary key,
    customer_id int not null references customers(id) on delete cascade,
    account_type varchar(50) not null,
    balance numeric(18, 2) not null default 0 check (balance >= 0),
    currency varchar(3) not null default 'USD',
    created_at timestamp with time zone default now()
);


Create table if not exists transactions (
    id bigserial primary key,
    account_id int not null references account(id) on delete cascade,
    txn_type varchar(50) not null,
    amount numeric (18, 2) not null check (amount > 0),
    related_account_id int null,
    status varchar(20) not null default 'comleted',
    created_at timestamp with time zone default now()
);


create index if not exists idx_transactions_account_created ON transactions (account_id, created_at);
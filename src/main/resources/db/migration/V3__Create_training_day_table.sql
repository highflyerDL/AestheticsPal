create table training_day (
	td_id			serial	primary key		not null,
	p_id			integer					not null references program(p_id),
	name			text					not null,
	exercises		integer[]
);
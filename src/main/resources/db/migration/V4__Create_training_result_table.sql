create table training_result (
	tr_id			serial	primary key		not null,
	td_id			integer					not null references training_day(td_id),
	e_id			integer					not null references exercise(e_id),
	trained_on		date,
	rep_count		integer					not null,
	weight			integer
);
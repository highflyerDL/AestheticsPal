create table exercise (
	e_id				integer	primary key		not null,
	name				text					not null,
	description			text,
	image				text[],
	muscle				text[],
	muscle_secondary	text[],
	category			integer
);

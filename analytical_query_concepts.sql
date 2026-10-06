-- drop table bricks cascade constraints;
create table bricks (
   brick_id integer,
   colour   varchar2(10),
   shape    varchar2(10),
   weight   integer
);

insert into bricks values
   ( 1,
     'blue',
     'cube',
     1 );
insert into bricks values
   ( 2,
     'blue',
     'pyramid',
     2 );
insert into bricks values
   ( 3,
     'red',
     'cube',
     1 );
insert into bricks values
   ( 4,
     'red',
     'cube',
     2 );
insert into bricks values
   ( 5,
     'red',
     'pyramid',
     3 );
insert into bricks values
   ( 6,
     'green',
     'pyramid',
     1 );

commit;

select *
  from bricks;

select count(*)
  from bricks;

select count(*)
       over()
  from bricks;

select b.*,
       count(*)
       over() total_count
  from bricks b;

select colour,
       count(*),
       sum(weight)
  from bricks
 group by colour;

select b.*,
       count(*)
       over(partition by colour) bricks_per_colour,
       sum(weight)
       over(partition by colour) weight_per_colour
  from bricks b;

select b.*,
       count(*)
       over(partition by shape) bricks_per_shape,
       median(weight)
       over(partition by shape) median_weight_per_shape
  from bricks b
 order by shape,
          weight,
          brick_id;

select b.*,
       count(*)
       over(
        order by brick_id) running_total,
       sum(weight)
       over(
           order by brick_id
       ) running_weight
  from bricks b;

select b.brick_id,
       b.weight,
       round(
          avg(weight)
          over(
              order by brick_id
          ),
          2
       ) running_average_weight
  from bricks b
 order by brick_id;

select b.*,
       count(*)
       over(partition by colour
            order by brick_id
       ) running_total,
       sum(weight)
       over(partition by colour
            order by brick_id
       ) running_weight
  from bricks b;

select b.*,
       count(*)
       over(
        order by weight) running_total,
       sum(weight)
       over(
           order by weight
       ) running_weight
  from bricks b
 order by weight;

select b.*,
       count(*)
       over(
           order by weight
          rows between unbounded preceding and current row
       ) running_total,
       sum(weight)
       over(
           order by weight
          rows between unbounded preceding and current row
       ) running_weight
  from bricks b
 order by weight;

select b.*,
       count(*)
       over(
           order by weight,
                    brick_id
          rows between unbounded preceding and current row
       ) running_total,
       sum(weight)
       over(
           order by weight,
                    brick_id
          rows between unbounded preceding and current row
       ) running_weight
  from bricks b
 order by weight,
          brick_id;

select b.*,
       sum(weight)
       over(
           order by weight
          rows between 1 preceding and current row
       ) running_row_weight,
       sum(weight)
       over(
           order by weight
          range between 1 preceding and current row
       ) running_value_weight,
       sum(weight)
       over(
           order by weight
          groups between 1 preceding and current row
       ) running_group_weight
  from bricks b
 order by weight,
          brick_id;

select b.*,
       sum(weight)
       over(
           order by weight
          rows between 1 preceding and 1 following
       ) sliding_row_window,
       sum(weight)
       over(
           order by weight
          range between 1 preceding and 1 following
       ) sliding_value_window,
       sum(weight)
       over(
           order by weight
          groups between 1 preceding and 1 following
       ) sliding_group_window
  from bricks b
 order by weight;
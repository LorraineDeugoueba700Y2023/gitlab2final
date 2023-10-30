
select * from film;
select * from language;

/*Subqueries:
  List the titles where the language is English or Italian*/
  
/*What are the language ids for English and Italian?*/
select language_id from sakila.language
   where name in ('English','Italian');                          
                              
/*What are the titles for films where the language IDs
  are either of the two language_ids found in the query above?*/                            
select title from sakila.film
   where language_id in (1,2);
   
/*Alternatively, use a subquery to do it in one step*/
select title from sakila.film
   where language_id in (select language_id from sakila.language
                         where name in ('English','Italian'));
  
/*************************************/  
  
/*How many records are in the customer and address tables*/
select count(*) from sakila.customer;
select count(*) from sakila.address;

/*Cartesian Product of customer and address tables*/
select customer.first_name, customer.last_name, address.address
from sakila.customer, sakila.address;

/*Cartesian Product using JOIN*/
select customer.first_name, customer.last_name, address.address
from sakila.customer JOIN sakila.address;

/*Cartesian Product using JOIN and table aliases*/
select a.first_name, a.last_name,  b.address
from sakila.customer a JOIN sakila.address b;


/*******************************************/

/*ANSI syntax join*/
select a.first_name, a.last_name,  b.address
from sakila.customer a JOIN sakila.address b
where a.address_id=b.address_id;

/*******************************************/

/*inner join*/
select a.first_name, a.last_name,  b.address
from sakila.customer a 
   INNER JOIN sakila.address b
   ON a.address_id=b.address_id;
  
/*or with "using"*/
select a.first_name, a.last_name,  b.address
from sakila.customer a 
   INNER JOIN sakila.address b
   USING (address_id);
   
/*******************************************/

/*Join three tables to capture city*/
select a.first_name, a.last_name,  b.address, c.city
from sakila.customer a 
   INNER JOIN sakila.address b
   using(address_id)
   inner join sakila.city c
   using(city_id);
      
/*************************************/

/*SECTION HEADING: Use a subquery to capture the city and the address*/
/* STEP 1: What are the addresses and cities*/
select a.address, b.city
from sakila.address a
inner join sakila.city b
on a.city_id=b.city_id;

/* STEP 2: Include the query above as a subquery in your join*/   
select a.first_name, a.last_name,  d.address, d.city
from sakila.customer a 
   INNER JOIN (select b.address_id, b.address, c.city
               from sakila.address b
               inner join sakila.city c
               on b.city_id=c.city_id) d
   on a.address_id=d.address_id;
   
select count(customer_id) from sakila.customer;
select
  SUM(IF(gender = 'female', 1, 0)) AS 'Female',
  SUM(IF(gender = 'male', 1, 0)) AS 'Male'
from customer;
      
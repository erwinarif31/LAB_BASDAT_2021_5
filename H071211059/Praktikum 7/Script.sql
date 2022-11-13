select distinct c.customerName,
		(select max(amount) from payments p where p.customerNumber = c.customerNumber),
		(select min(amount) from payments p where p.customerNumber = c.customerNumber)
from customers c
right join payments p2 using (customerNumber);

select e.employeeNumber, e.lastName, e.firstName, o.city, e.officeCode 
from employees e 
join offices o using (officeCode)
where e.officeCode = (select e2.officeCode from employees e2 group by e2.officeCode order by count(*) desc limit 1);
;

select p.productName , 
	(select p2.productScale  from products p2 where p2.productCode = p.productCode)
from products p 
where p.productName like "%ford%"
;

from customers c 
join employees e on c.salesRepEmployeeNumber = e.employeeNumber
join orders o using (customerNumber)
join orderdetails o2 using (orderNumber)
where o.orderNumber = 
			(select orderNumber 
			from orderdetails o 
			group by orderNumber 
			order by sum(o.quantityOrdered * o.priceEach) desc limit 1)
;


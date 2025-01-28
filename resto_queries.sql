#Task 1
/*create view OrdersView as 
select orderId, quantity, totalAmount as price from Orders where quantity > 2;

select * from OrdersView;
*/




#Task 2
/*
select Customer.customerId, concat(Customer.name, " ", Customer.surname), Orders.orderId, Orders.totalAmount as price, Menus.name as MenuName, MenuItems.CourseName as CourseName from Customer 
inner join Orders on Orders.customerId = Customer.customerId 
inner join Menus on Menus.menuId = Orders.menuId
inner join ItemsInMenu on Menus.menuId = ItemsInMenu.Menus_menuId
inner join MenuItems on ItemsInMenu.MenuItems_MenuItemsId = MenuItems.MenuItemsId
where price > 10;
*/


#Task 3

#select name as MenuName from Menus where Menus.menuId = any(select orderId from Orders where quantity > 2);


#Task 4
/*
DROP PROCEDURE IF EXISTS GetMaxQuantity;

DELIMITER $$

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(quantity)  FROM Orders;
END $$

DELIMITER ;

call GetMaxQuantity();
*/

#Task 5
/*
set @sqlQyery = 'select orderId, quantity, totalAmount from Orders where orderId = ?';
prepare GetOrderDetail from @sqlQyery;

set @id = 1;
execute GetOrderDetail using @id;
*/

# Task 6
/*
delimiter //
create procedure CancelOrder(in orderId int)
begin
select concat("Order ", orderId, " is cancelled");
end //
delimiter ;

call CancelOrder(5);
*/


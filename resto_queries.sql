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

# Task 7
# update Bookings set date = '2022-10-13', `table` = '2', customerId = 1 where bookingsId = 4;

# Task 8
/*
drop procedure if exists CheckBooking;

delimiter //
create procedure CheckBooking(in booking_date date, in table_nubmer varchar(45))
begin
select if (numberOfGuests > 0, 
concat("Table ", table_nubmer, " is booked"), 
concat("Table ", `table`, " is free to book")) as Booking_status
from Bookings where `table` = table_nubmer and date = booking_date;
end; //

delimiter ;

call CheckBooking("2022-11-12", "3");
*/

# Task 9
/*
drop procedure if exists AddValidBooking;

DELIMITER //

CREATE PROCEDURE AddValidBooking(
    IN booking_date DATE, 
    IN table_number VARCHAR(45), 
    IN numberOfGuests INT,
    IN employeeId INT, 
    IN customerId INT
)
BEGIN 
    DECLARE id_number INT;
    DECLARE number_of_guest INT;
    
    SELECT COUNT(bookingsId) + 1 INTO  id_number
    FROM Bookings;
    
    select numberOfGuests into number_of_guest from Bookings where `table` = table_number AND date = booking_date;
    
    START TRANSACTION;

    IF number_of_guest > 0 THEN 
        SELECT CONCAT("The table ", table_number, " is already booked on ", booking_date) AS BookingStatus;
        ROLLBACK;
    ELSE 

        INSERT INTO Bookings (bookingsId, `table`, date, numberOfGuests, employeeId, customerId) 
        VALUES (id_number, table_number, booking_date, numberOfGuests, employeeId, customerId);

        COMMIT;
        
        SELECT CONCAT("Booking added for table ", table_number, " on ", booking_date) AS BookingStatus;
    END IF;
END //

DELIMITER ;

call AddValidBooking("2022-12-17", "6", 2, 1, 2);

*/


# Task10 

/*
DELIMITER //

create procedure AddBooking(
in bookingsId int, in customerId int,
in bookingDate date, in table_number varchar(45)
)
begin 
start transaction;
insert into Bookings values (bookingsId, table_number, bookingDate, 2, 1, customerId);
select concat("The booking : ",bookingsId, " was added :)");
commit;
end //

DELIMITER //;

call AddBooking(7, 1, "2022-12-18", "3")

*/

# Task 11
/*
drop procedure if exists UpdateBooking;

delimiter //
create procedure UpdateBooking(in booking_id int, in booking_date date)
begin
update Bookings set date = booking_date where bookingsId = booking_id;
select concat("The booking's: ", booking_id, " time is updated");
end; //

delimiter ;

call UpdateBooking(7, "2022-12-19");

*/



# Task 12

/*
drop procedure if exists CancelBooking;

delimiter //
create procedure CancelBooking(in booking_id int)
begin
declare booking_exist int;

select count(*) into booking_exist from Bookings where booking_id = bookingsId;

start transaction;

if booking_exist > 0 
then delete from Bookings where booking_id = bookingsId;
select concat("The booking: ", booking_id, " is deleted :)");
commit;

else
select concat("The booking: ", booking_id, " doesn't exist");
rollback;

end if;

end; //

delimiter ;

*/



select shape, color, round((case 
	when shape="triangle" then (sqrt(3)/4 * pow(side1, 2)) 
	when shape = "square" then pow(side1, 2) 
	when shape = "rectangle" then (side1 * side2) 
	when shape = "circle" then (pi() * pow(side1, 2)) 
	end ), 3) as AREA 
from blocks;
-- +-----------+--------+---------+
-- | shape     | color  | AREA    |
-- +-----------+--------+---------+
-- | triangle  | red    |  10.825 |
-- | square    | red    |  25.000 |
-- | rectangle | red    |   8.000 |
-- | circle    | red    |  78.540 |
-- | circle    | blue   |  12.566 |
-- | square    | blue   |  49.000 |
-- | square    | yellow |  64.000 |
-- | triangle  | yellow |   1.732 |
-- | triangle  | blue   |   3.897 |
-- | circle    | green  | 314.159 |
-- | square    | green  |   1.000 |
-- | square    | cyan   |  16.000 |
-- | rectangle | cyan   |  56.000 |
-- | rectangle | yellow |  10.000 |
-- | rectangle | white  |  20.000 |
-- | circle    | white  |  50.265 |
-- +-----------+--------+---------+
-- 16 rows in set (0.00 sec)



select shape, round( 
	sum( (case  when shape="triangle" then (sqrt(3)/4 * pow(side1, 2)) 
	when shape = "square" then pow(side1, 2)  
	when shape = "rectangle" then (side1 * side2)  
	when shape = "circle" then (pi() * pow(side1, 2))  end )),
3) as AREA from blocks 
group by shape;
-- +-----------+---------+
-- | shape     | AREA    |
-- +-----------+---------+
-- | circle    | 455.531 |
-- | rectangle |  94.000 |
-- | square    | 155.000 |
-- | triangle  |  16.454 |
-- +-----------+---------+
-- 4 rows in set (0.00 sec)


select shape, color, round(( (case 
	when shape="triangle" then (sqrt(3)/4 * pow(side1, 2))
	when shape = "square" then pow(side1, 2) 
	when shape = "rectangle" then (side1 * side2) 
	when shape = "circle" then (pi() * pow(side1, 2)) 
	end ) * bq.qty), 3) as AREA 
from blocks b inner join block_qty bq 
on b.id = bq.block_id;
-- +-----------+--------+----------+
-- | shape     | color  | AREA     |
-- +-----------+--------+----------+
-- | triangle  | red    |   75.777 |
-- | square    | red    |  125.000 |
-- | rectangle | red    |   24.000 |
-- | circle    | red    |  157.080 |
-- | circle    | blue   |    0.000 |
-- | square    | blue   |  245.000 |
-- | square    | yellow |  320.000 |
-- | triangle  | yellow |   13.856 |
-- | triangle  | blue   |   15.588 |
-- | circle    | green  | 2513.274 |
-- | square    | green  |    8.000 |
-- | square    | cyan   |   96.000 |
-- | rectangle | cyan   |  336.000 |
-- | rectangle | yellow |   10.000 |
-- | rectangle | white  |  140.000 |
-- +-----------+--------+----------+
-- 15 rows in set (0.00 sec)



select color, round(
	sum(((case 
  	when shape="triangle" then (sqrt(3)/4 * pow(side1, 2))  
  	when shape = "square" then pow(side1, 2) 
  	when shape = "rectangle" then (side1 * side2)   
  	when shape = "circle" then (pi() * pow(side1, 2))   
  	end  
  ) * bq.qty)
), 3) as AREA  
from blocks b inner join block_qty bq  
on b.id = bq.block_id  
group by b.color 
having AREA > (15 * 20);
-- +--------+----------+
-- | color  | AREA     |
-- +--------+----------+
-- | cyan   |  432.000 |
-- | green  | 2521.274 |
-- | red    |  381.857 |
-- | yellow |  343.856 |
-- +--------+----------+
-- 4 rows in set (0.00 sec)





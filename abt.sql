SELECT
  sm.product_id,
  p.name AS product_name,
  p.category_id,
  c.name AS category_name,
  com.frequency,
  DATE(sm.movement_date) AS movement_date,
  SUM(sm.quantity) AS total_quantity_out
FROM stock_movements sm
JOIN products p ON sm.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
JOIN category_order_map com ON c.category_id = com.category_id AND p.establishment_id = com.establishment_id
WHERE sm.type = 'OUT'
GROUP BY sm.product_id, p.name, p.category_id, c.name, com.frequency, DATE(sm.movement_date)
ORDER BY sm.product_id, movement_date
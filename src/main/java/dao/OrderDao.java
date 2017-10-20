package dao;

import entity.Order;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface OrderDao {

    public List<Order> orderList(Map map);

    public int allOrders();

    public int isExist(String num);

    public void updateOrder(Order order);
}

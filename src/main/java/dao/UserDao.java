package dao;

/**
 * Created by ccc on 2017/4/20
 */
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import entity.User;

import java.util.List;

@Repository("UserDao")
public interface UserDao {

    /**
     *  Created by ccc on 2017/4/20
     *  根据用户名和密码查询用户
     * @param username
     * @param password
     * @return
     */
    public User findByUsernameAndPwd(@Param("username") String username, @Param("password") String password);

    /**
     *  Created by ccc on 2017/4/20
     *  获取用户
     * @return
     */
    public List<User> find(User User);

    /**
     *  Created by ccc on 2017/4/20
     *  新增
     * @param User
     */
    public void add(User User);

    /**
     *  Created by ccc on 2017/4/20
     *  修改
     * @param User
     */
    public void update(User User);

    /**
     *  Created by ccc on 2017/4/20
     *  删除
     * @param id
     */
    public void delete(String id);
}
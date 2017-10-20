package service;

/**
 * Created by ccc on 2017/04/20.
 */
import entity.User;

import java.util.List;

public interface UserService {

    /**
     *  Created by ccc on 2017/04/20.
     *  根据用户名和密码查询用户
     * @param username
     * @param password
     * @return
     */
    public User findByUsernameAndPwd(String username, String password);

    /**
     *  Created by ccc on 2017/04/20.
     *  获取用户
     * @return
     */
    public List<User> find(User User);

    /**
     *  Created by ccc on 2017/04/20.
     *  新增
     * @param User
     */
    public void add(User User);

    /**
     *  Created by ccc on 2017/04/20.
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

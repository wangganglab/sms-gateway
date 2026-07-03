package com.hero.wireless.web.dao.ibatis.send.ext;

import com.hero.wireless.web.dao.ibatis.MybatisBaseSendExtDao;
import com.hero.wireless.web.dao.send.ext.IUnsubscribeLogExtDAO;
import com.hero.wireless.web.entity.send.UnsubscribeLog;
import com.hero.wireless.web.entity.send.UnsubscribeLogExample;
import com.hero.wireless.web.entity.send.ext.UnsubscribeLogExt;
import org.springframework.stereotype.Repository;

@Repository("unsubscribeLogExtDAO")
public class UnsubscribeLogExtDAOImpl extends MybatisBaseSendExtDao<UnsubscribeLogExt, UnsubscribeLogExample, UnsubscribeLog> implements IUnsubscribeLogExtDAO {
}

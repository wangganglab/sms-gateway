package com.hero.wireless.web.dao.ibatis.business.ext;

import com.hero.wireless.web.dao.business.ext.ICooperationPeriodExtDAO;
import com.hero.wireless.web.dao.ibatis.MybatisBaseBusinessExtDao;
import com.hero.wireless.web.entity.business.CooperationPeriod;
import com.hero.wireless.web.entity.business.CooperationPeriodExample;
import com.hero.wireless.web.entity.business.ext.CooperationPeriodExt;
import org.springframework.stereotype.Repository;

@Repository("cooperationPeriodExtDAO")
public class CooperationPeriodExtDAOImpl extends MybatisBaseBusinessExtDao<CooperationPeriodExt, CooperationPeriodExample, CooperationPeriod> implements ICooperationPeriodExtDAO {
}

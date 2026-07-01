package com.hero.wireless.web.dao.business;

import com.hero.wireless.web.dao.base.IDao;
import com.hero.wireless.web.entity.business.CooperationPeriod;
import com.hero.wireless.web.entity.business.CooperationPeriodExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ICooperationPeriodDAO<T extends CooperationPeriod> extends IDao<CooperationPeriod, CooperationPeriodExample> {
    int countByExample(CooperationPeriodExample example);

    int deleteByExample(CooperationPeriodExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(CooperationPeriod record);

    int insertList(List<CooperationPeriod> list);

    int insertSelective(CooperationPeriod record);

    List<CooperationPeriod> selectByExample(CooperationPeriodExample example);

    CooperationPeriod selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") CooperationPeriod record, @Param("example") CooperationPeriodExample example);

    int updateByExample(@Param("record") CooperationPeriod record, @Param("example") CooperationPeriodExample example);

    int updateByPrimaryKeySelective(CooperationPeriod record);

    int updateByPrimaryKey(CooperationPeriod record);
}

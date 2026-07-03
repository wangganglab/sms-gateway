package com.hero.wireless.web.dao.send;

import com.hero.wireless.web.dao.base.IDao;
import com.hero.wireless.web.entity.send.UnsubscribeLog;
import com.hero.wireless.web.entity.send.UnsubscribeLogExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IUnsubscribeLogDAO<T extends UnsubscribeLog> extends IDao<UnsubscribeLog, UnsubscribeLogExample> {
    int countByExample(UnsubscribeLogExample example);

    int deleteByExample(UnsubscribeLogExample example);

    int deleteByPrimaryKey(Long id);

    int insert(UnsubscribeLog record);

    int insertList(List<UnsubscribeLog> list);

    int insertSelective(UnsubscribeLog record);

    List<UnsubscribeLog> selectByExample(UnsubscribeLogExample example);

    UnsubscribeLog selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") UnsubscribeLog record, @Param("example") UnsubscribeLogExample example);

    int updateByExample(@Param("record") UnsubscribeLog record, @Param("example") UnsubscribeLogExample example);

    int updateByPrimaryKeySelective(UnsubscribeLog record);

    int updateByPrimaryKey(UnsubscribeLog record);
}

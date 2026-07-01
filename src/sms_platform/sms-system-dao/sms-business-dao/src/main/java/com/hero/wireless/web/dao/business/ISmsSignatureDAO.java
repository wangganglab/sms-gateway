package com.hero.wireless.web.dao.business;

import com.hero.wireless.web.dao.base.IDao;
import com.hero.wireless.web.entity.business.SmsSignature;
import com.hero.wireless.web.entity.business.SmsSignatureExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ISmsSignatureDAO<T extends SmsSignature> extends IDao<SmsSignature, SmsSignatureExample> {
    int countByExample(SmsSignatureExample example);

    int deleteByExample(SmsSignatureExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(SmsSignature record);

    int insertList(List<SmsSignature> list);

    int insertSelective(SmsSignature record);

    List<SmsSignature> selectByExample(SmsSignatureExample example);

    SmsSignature selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") SmsSignature record, @Param("example") SmsSignatureExample example);

    int updateByExample(@Param("record") SmsSignature record, @Param("example") SmsSignatureExample example);

    int updateByPrimaryKeySelective(SmsSignature record);

    int updateByPrimaryKey(SmsSignature record);
}

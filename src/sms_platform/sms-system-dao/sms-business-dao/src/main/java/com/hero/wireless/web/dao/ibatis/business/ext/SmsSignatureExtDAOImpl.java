package com.hero.wireless.web.dao.ibatis.business.ext;

import com.hero.wireless.web.dao.business.ext.ISmsSignatureExtDAO;
import com.hero.wireless.web.dao.ibatis.MybatisBaseBusinessExtDao;
import com.hero.wireless.web.entity.business.SmsSignature;
import com.hero.wireless.web.entity.business.SmsSignatureExample;
import com.hero.wireless.web.entity.business.ext.SmsSignatureExt;
import org.springframework.stereotype.Repository;

@Repository("smsSignatureExtDAO")
public class SmsSignatureExtDAOImpl extends MybatisBaseBusinessExtDao<SmsSignatureExt, SmsSignatureExample, SmsSignature> implements ISmsSignatureExtDAO {
}

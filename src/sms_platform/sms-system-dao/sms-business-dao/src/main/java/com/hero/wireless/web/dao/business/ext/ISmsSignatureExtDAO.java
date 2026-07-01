package com.hero.wireless.web.dao.business.ext;

import com.hero.wireless.web.dao.business.ISmsSignatureDAO;
import com.hero.wireless.web.dao.ext.IExtDAO;
import com.hero.wireless.web.entity.business.SmsSignature;
import com.hero.wireless.web.entity.business.SmsSignatureExample;
import com.hero.wireless.web.entity.business.ext.SmsSignatureExt;

public interface ISmsSignatureExtDAO extends ISmsSignatureDAO<SmsSignature>, IExtDAO<SmsSignatureExt, SmsSignatureExample> {
}

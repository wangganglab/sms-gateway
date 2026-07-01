package com.hero.wireless.web.entity.business.ext;

import com.hero.wireless.web.entity.business.Enterprise;
import com.hero.wireless.web.entity.business.SmsSignature;

public class SmsSignatureExt extends SmsSignature {

	private Enterprise enterprise;

	public Enterprise getEnterprise() {
		return enterprise;
	}

	public void setEnterpriseInfo(Enterprise enterprise) {
		this.enterprise = enterprise;
	}

}

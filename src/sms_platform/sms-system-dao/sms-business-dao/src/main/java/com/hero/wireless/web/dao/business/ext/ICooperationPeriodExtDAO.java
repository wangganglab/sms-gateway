package com.hero.wireless.web.dao.business.ext;

import com.hero.wireless.web.dao.business.ICooperationPeriodDAO;
import com.hero.wireless.web.dao.ext.IExtDAO;
import com.hero.wireless.web.entity.business.CooperationPeriod;
import com.hero.wireless.web.entity.business.CooperationPeriodExample;
import com.hero.wireless.web.entity.business.ext.CooperationPeriodExt;

public interface ICooperationPeriodExtDAO extends ICooperationPeriodDAO<CooperationPeriod>, IExtDAO<CooperationPeriodExt, CooperationPeriodExample> {
}

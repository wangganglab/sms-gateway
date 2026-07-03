package com.hero.wireless.web.dao.send.ext;

import com.hero.wireless.web.dao.ext.IExtDAO;
import com.hero.wireless.web.dao.send.IUnsubscribeLogDAO;
import com.hero.wireless.web.entity.send.UnsubscribeLog;
import com.hero.wireless.web.entity.send.UnsubscribeLogExample;
import com.hero.wireless.web.entity.send.ext.UnsubscribeLogExt;

public interface IUnsubscribeLogExtDAO extends IUnsubscribeLogDAO<UnsubscribeLogExt>, IExtDAO<UnsubscribeLogExt, UnsubscribeLogExample> {
}

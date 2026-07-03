package com.hero.wireless.web.service;

import com.drondea.wireless.config.Constant;
import com.drondea.wireless.config.ResultStatus;
import com.drondea.wireless.util.*;
import com.hero.wireless.enums.AccountStatus;
import com.hero.wireless.web.config.DatabaseCache;
import com.hero.wireless.web.config.SystemKey;
import com.hero.wireless.web.entity.base.Pagination;
import com.hero.wireless.web.entity.business.*;
import com.hero.wireless.web.entity.business.ext.*;
import com.hero.wireless.web.entity.send.UnsubscribeLog;
import com.hero.wireless.web.entity.send.UnsubscribeLogExample;
import com.hero.wireless.web.entity.send.ext.UnsubscribeLogExt;
import com.hero.wireless.web.entity.ext.SqlStatisticsEntity;
import com.hero.wireless.web.exception.BaseException;
import com.hero.wireless.web.service.base.BaseEnterpriseManage;
import com.hero.wireless.web.util.CodeUtil;
import com.hero.wireless.web.util.SMSUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map;
import java.util.function.Consumer;
import java.util.stream.Collectors;

import static com.hero.wireless.web.config.MessagesManger.getSystemMessages;

@Service("enterpriseManage")
public class EnterpriseManageImpl extends BaseEnterpriseManage implements IEnterpriseManage {

    @javax.annotation.Resource(name = "codeExtDAO")
    private com.hero.wireless.web.dao.business.ext.ICodeExtDAO codeDAO;

    @Override
    public List<Enterprise> queryEnterpriseList(EnterpriseExt condition) {
        EnterpriseExample example = assemblyEnterpriseConditon(condition);
        return this.enterpriseDAO.selectByExamplePage(example);
    }

    @Override
    public Enterprise addEnterprise(Enterprise data) {
        EnterpriseExample enterpriseExample = new EnterpriseExample();
        enterpriseExample.createCriteria().andNameEqualTo(data.getName()).andStatusNotEqualTo(AccountStatus.DELETE.toString());
        List<Enterprise> enterprises = enterpriseDAO.selectByExample(enterpriseExample);
        if (enterprises != null && !enterprises.isEmpty()) {
            throw new ServiceException("该企业名称已被占用");
        }
        // 校验信用代码唯一性
        if (StringUtils.isNotEmpty(data.getCredit_Code())) {
            EnterpriseExample creditExample = new EnterpriseExample();
            creditExample.createCriteria().andCredit_CodeEqualTo(data.getCredit_Code()).andStatusNotEqualTo(AccountStatus.DELETE.toString());
            List<Enterprise> creditDuplicates = enterpriseDAO.selectByExample(creditExample);
            if (creditDuplicates != null && !creditDuplicates.isEmpty()) {
                throw new ServiceException("该信用代码已被使用");
            }
        }
        if (StringUtils.isEmpty(data.getAgent_No())) {
            data.setAgent_No(SMSUtil.DEFAULT_NO);//设置默认代理商编号 0000000000000000
        }
        data.setNo(CodeUtil.buildEnterpriseNo());
        data.setCreate_Date(new Date());
        data.setAvailable_Amount(new BigDecimal(0));// 可用金额
        data.setUsed_Amount(new BigDecimal(0));
        data.setSent_Count(0);
        data.setStatus("Normal");
        this.enterpriseDAO.insert(data);
        return data;
    }

    @Override
    public Enterprise queryEnterpriseById(int id) {
        Enterprise reutrnValue = this.enterpriseDAO.selectByPrimaryKey(id);
        return reutrnValue;
    }

    @Override
    public List<EnterpriseUser> queryEnterpriseUserList(EnterpriseUserExt condition) {
        EnterpriseUserExample example = assemblyEnterpriseUserConditon(condition);
        return enterpriseUserDAO.selectByExamplePage(example);
    }

    //增加同步块，防止快速点击多次，用户名重复问题
    @Override
    public EnterpriseUser addEnterpriseUser(EnterpriseUserExt userInfo) {
        // 检查用户名是否可用
        doCheckUserName(userInfo);
        // 设置用户默认值
        doAddUserDefaultValue(userInfo);
        // 插入用户信息
        this.enterpriseUserDAO.insert(userInfo);
        // 更新cmppusername
        //TODO 这样实现不是很好
        EnterpriseUser updateUser = new EnterpriseUser();
        updateUser.setId(userInfo.getId());
        updateUser.setTcp_User_Name(SMSUtil.getCmppUser(userInfo.getId()));
        this.enterpriseUserDAO.updateByPrimaryKeySelective(updateUser);
        // 绑定角色
        doBindRole(userInfo);
        return userInfo;
    }

    @Override
    public List<EnterpriseLimit> queryEnterpriseLimitList(EnterpriseLimit condition) {
        EnterpriseLimitExample example = new EnterpriseLimitExample();
        EnterpriseLimitExample.Criteria cri = example.createCriteria();
        if (!StringUtils.isEmpty(condition.getUp_Code())) {
            cri.andUp_CodeEqualTo(condition.getUp_Code());
        }
        if (!StringUtils.isEmpty(condition.getName())) {
            cri.andNameLike("%" + condition.getName() + "%");
        }
        if (condition.getId() != null) {
            cri.andIdEqualTo(condition.getId());
        }
        example.setPagination(condition.getPagination());
        List<EnterpriseLimit> list = this.enterpriseLimitDAO.selectByExamplePage(example);
        return list;
    }

    @Override
    public EnterpriseLimit addEnterpriseLimit(EnterpriseLimit data) {
        data.setCreate_Date(new Date());
        EnterpriseLimitExample example = new EnterpriseLimitExample();
        EnterpriseLimitExample.Criteria cri = example.createCriteria();
        if (!StringUtils.isEmpty(data.getCode())) {
            cri.andCodeEqualTo(data.getCode());
        }
        // Code不能重复
        List<EnterpriseLimit> list = this.enterpriseLimitDAO.selectByExample(example);
        if (list != null && !list.isEmpty()) {
            throw new ServiceException(ResultStatus.LIMIT_CODE_EXSITS, data.getCode());
        }
        this.enterpriseLimitDAO.insert(data);
        return data;
    }

    @Override
    public List<EnterpriseRole> queryEnterpriseRoleList(EnterpriseRole condition) {
        EnterpriseRoleExample example = new EnterpriseRoleExample();
        EnterpriseRoleExample.Criteria cri = example.createCriteria();
        if (!StringUtils.isEmpty(condition.getUp_Code())) {
            cri.andUp_CodeEqualTo(condition.getUp_Code());
        }
        if (!StringUtils.isEmpty(condition.getName())) {
            cri.andNameLike("%" + condition.getName() + "%");
        }
        if (condition.getId() != null) {
            cri.andIdEqualTo(condition.getId());
        }
        example.setPagination(condition.getPagination());
        List<EnterpriseRole> list = this.enterpriseRoleDAO.selectByExamplePage(example);
        return list;
    }

    @Override
    public EnterpriseRole addEnterpriseRole(EnterpriseRole data) {
        data.setCreate_Date(new Date());
        EnterpriseRoleExample example = new EnterpriseRoleExample();
        EnterpriseRoleExample.Criteria cri = example.createCriteria();
        if (!StringUtils.isEmpty(data.getCode())) {
            cri.andCodeEqualTo(data.getCode());
        }
        List<EnterpriseRole> list = this.enterpriseRoleDAO.selectByExample(example);
        if (list != null && !list.isEmpty()) {
            throw new ServiceException(ResultStatus.ROLE_CODE_EXSITS, data.getCode());
        }
        this.enterpriseRoleDAO.insert(data);
        return data;
    }

    @Override
    public List<EnterpriseRoleExt> queryBindUserRoleList(List<Integer> userIdList) {
        if (userIdList == null || userIdList.isEmpty()) {
            return null;
        }
        return this.enterpriseRoleExtDAO.selectBindUserRoleByExample(userIdList.get(0));
    }

    @Override
    public List<EnterpriseLimitExt> queryBindRoleLimitList(List<Integer> roleIdList) {
        if (roleIdList == null || roleIdList.isEmpty()) {
            return null;
        }
        return this.enterpriseLimitExtDAO.selectBindRoleLimitByExample(roleIdList.get(0));
    }

    @Override
    public boolean bindUserRole(List<EnterpriseUserRoles> userRoleList) {
        EnterpriseUserRolesExample example = null;
        EnterpriseUserRolesExample.Criteria cri = null;
        for (int i = 0; i < userRoleList.size(); i++) {
            example = new EnterpriseUserRolesExample();
            cri = example.createCriteria();
            cri.andEnterprise_User_IdEqualTo(userRoleList.get(i).getEnterprise_User_Id());
            int returnResult = this.enterpriseUserRolesDAO.deleteByExample(example);
            SuperLogger.debug("删除行数:" + returnResult);
        }
        for (int i = 0; i < userRoleList.size(); i++) {
            userRoleList.get(i).setCreate_Date(new Date());
            this.enterpriseUserRolesDAO.insert(userRoleList.get(i));
        }
        return true;
    }

    @Override
    public boolean bindRoleLimit(List<EnterpriseRoleLimit> roleLimitList) {
        // 删除现有的权限
        List<Integer> roleIds = new ArrayList<>();
        for (int i = 0; i < roleLimitList.size(); i++) {
            roleIds.add(roleLimitList.get(i).getRole_Id());
        }
        if (!roleIds.isEmpty()) {
            EnterpriseRoleLimitExample example = new EnterpriseRoleLimitExample();
            EnterpriseRoleLimitExample.Criteria cri = example.createCriteria();
            cri.andRole_IdIn(roleIds);
            this.enterpriseRoleLimitDAO.deleteByExample(example);
        }
        for (int i = 0; i < roleLimitList.size(); i++) {
            roleLimitList.get(i).setCreate_Date(new Date());
        }
        if (!roleLimitList.isEmpty()) {
            this.enterpriseRoleLimitDAO.insertList(roleLimitList);
        }
        return true;
    }

    @Override
    public Integer editEnterprise(EnterpriseExt enterpriseExt) throws Exception {
        if (StringUtils.isBlank(enterpriseExt.getAgent_No())) {
            enterpriseExt.setAgent_No(SMSUtil.DEFAULT_NO);//设置默认代理商编号 0000000000000000
        }
        // 校验信用代码唯一性（排除自己）
        if (StringUtils.isNotEmpty(enterpriseExt.getCredit_Code())) {
            EnterpriseExample creditExample = new EnterpriseExample();
            creditExample.createCriteria().andCredit_CodeEqualTo(enterpriseExt.getCredit_Code())
                .andIdNotEqualTo(enterpriseExt.getId()).andStatusNotEqualTo(AccountStatus.DELETE.toString());
            List<Enterprise> creditDuplicates = enterpriseDAO.selectByExample(creditExample);
            if (creditDuplicates != null && !creditDuplicates.isEmpty()) {
                throw new ServiceException("该信用代码已被使用");
            }
        }
        if (StringUtils.isNotBlank(enterpriseExt.getAuthentication_State_Code())) {
            enterpriseExt.setAuthentication_State_Code(enterpriseExt.getAuthentication_State_Code());
        }
        Integer result = this.enterpriseDAO.updateByPrimaryKeySelective(enterpriseExt);
        return result;
    }

    @Override
    public List<Integer> updateEnterpriseStatus(List<Integer> eidList, String status) {
        List<Integer> result = new ArrayList<>();
        if (eidList == null || eidList.isEmpty()) {
            return result;
        }
        EnterpriseExample example = new EnterpriseExample();
        EnterpriseExample.Criteria cri = example.createCriteria();
        cri.andIdIn(eidList);
        List<Enterprise> enterprises = enterpriseDAO.selectByExample(example);
        Enterprise record = new Enterprise();
        record.setStatus(status);
        this.enterpriseDAO.updateByExampleSelective(record, example);
        //2019/12/30 锁定企业下所有用户,2020/09/03删除企业下所有用户
        if (AccountStatus.LOCKED.toString().equals(status) || AccountStatus.DELETE.toString().equals(status)) {
            EnterpriseUserExample userExample = new EnterpriseUserExample();
            EnterpriseUserExample.Criteria userCri = userExample.createCriteria();
            userCri.andEnterprise_NoIn(enterprises.stream().map(Enterprise::getNo).collect(Collectors.toList()));
            List<EnterpriseUser> userList = enterpriseUserDAO.selectByExample(userExample);
            if (userList != null && !userList.isEmpty()) {
                List<Integer> uIdList = userList.stream().map(EnterpriseUser::getId).collect(Collectors.toList());
                this.updateEnterpriseUserStatus(uIdList, status);
                result = uIdList;
            }
        }
        return result;
    }

    @Override
    public EnterpriseUser queryEnterpriseUserById(Integer id) {
        if (id == null || id == 0) {
            return null;
        }
        return enterpriseUserDAO.selectByPrimaryKey(id);
    }

    @Override
    public Integer editUser(EnterpriseUserExt enterpriseUser) {
        if (StringUtils.isNotEmpty(enterpriseUser.getPassword())) {
            enterpriseUser.setWeb_Password(SecretUtil.MD5(enterpriseUser.getPassword()));
        }
        if (StringUtils.isNotBlank(enterpriseUser.getUser_Name())) {//编辑用户
            EnterpriseUserExample example = new EnterpriseUserExample();
            EnterpriseUserExample.Criteria criteria = example.createCriteria();
            criteria.andUser_NameEqualTo(enterpriseUser.getUser_Name());
            criteria.andIdNotEqualTo(enterpriseUser.getId());
            if (ObjectUtils.isNotEmpty(enterpriseUserDAO.selectByExample(example))) {
                throw new ServiceException(ResultStatus.USER_NAME_EXSITS);
            }
        }
        if (ObjectUtils.isNotEmpty(enterpriseUser.getReturn_Unknown_Rate())) {
            if (enterpriseUser.getReturn_Unknown_Rate() < 0 || enterpriseUser.getReturn_Unknown_Rate() > 1) {
                throw new ServiceException(ResultStatus.RETURN_UNKNOWN_RATE_ERROR);
            }
        }

        int result = this.enterpriseUserDAO.updateByPrimaryKeySelective(enterpriseUser);
        return result;
    }

    @Override
    public Integer updateEnterpriseUserStatus(List<Integer> uIdList, String status) {
        if (uIdList == null || uIdList.isEmpty()) {
            return 0;
        }
        EnterpriseUserExample example = new EnterpriseUserExample();
        EnterpriseUserExample.Criteria cri = example.createCriteria();
        cri.andIdIn(uIdList);
        EnterpriseUser record = new EnterpriseUser();
        record.setStatus(status);
        int result = this.enterpriseUserDAO.updateByExampleSelective(record, example);
        return result;
    }

    @Override
    public Integer editLimit(EnterpriseLimit enterpriseLimit) {
        Integer result = this.enterpriseLimitDAO.updateByPrimaryKeySelective(enterpriseLimit);
        return result;
    }

    @Override
    public Integer editRole(EnterpriseRole enterpriseRole) {
        Integer result = this.enterpriseRoleDAO.updateByPrimaryKeySelective(enterpriseRole);
        return result;
    }

    @Override
    public EnterpriseUser userLogin(EnterpriseUser userInfo) {
        // rsa解密
        userInfo.setWeb_Password(getPlainPassword(userInfo.getWeb_Password()));

        EnterpriseUser loginUser = userLogin(userInfo.getUser_Name(), SecretUtil.MD5(userInfo.getWeb_Password()));
        //2020.03.05新增
        updateLoginUser(loginUser);
        insertSystemLog(loginUser);
        return loginUser;
    }

    //保存登录日志
    private void insertSystemLog(EnterpriseUser loginUser) {
        SystemLog log = new SystemLog();
        HttpServletRequest request = ((ServletRequestAttributes)
                RequestContextHolder.getRequestAttributes()).getRequest();
        String ip = IpUtil.getRemoteIpAddr(request);
        log.setUser_Id(loginUser.getId());
        log.setReal_Name(loginUser.getReal_Name());
        log.setUser_Name(loginUser.getUser_Name());
        log.setModule_Name("客户平台");
        log.setOperate_Desc("企业用户登录");
        log.setSpecific_Desc(loginUser.getReal_Name()+" 于 "+ DateTime.getString()+" 登录客户平台，登录ip："+ip);
        log.setIp_Address(ip);
        log.setCreate_Date(new Date());
        systemLogDAO.insert(log);
    }

    //更新用户登录信息
    private void updateLoginUser(EnterpriseUser loginUser) {
        EnterpriseUser newUser = new EnterpriseUser();
        newUser.setId(loginUser.getId());
        newUser.setLast_Login_Time(new Date());//登录时间
        HttpServletRequest request = ((ServletRequestAttributes)
                RequestContextHolder.getRequestAttributes()).getRequest();
        newUser.setLast_Login_IP(IpUtil.getRemoteIpAddr(request));//登录ip
        newUser.setLogin_Faild_Count(0);//初始化登录失败次数
        enterpriseUserDAO.updateByPrimaryKeySelective(newUser);
    }

    @Override
    public EnterpriseUser userLogin(String userName, String password) {
        return userLogin(userName, e -> e.andWeb_PasswordEqualTo(password));
    }

    /**
     * @param userName
     * @param consumer
     * @return
     * @author volcano
     * @date 2019年9月16日上午3:45:34
     * @version V1.0
     */
    public EnterpriseUser userLogin(String userName, Consumer<EnterpriseUserExample.Criteria> consumer) {
        // 用户登录
        EnterpriseUserExample auie = new EnterpriseUserExample();
        EnterpriseUserExample.Criteria cri = auie.createCriteria();
        cri.andUser_NameEqualTo(userName);
        consumer.accept(cri);
        List<EnterpriseUserExt> auiList = enterpriseUserExtDAO.selectRolesAndLimitsByExample(auie);
        if (auiList == null || auiList.isEmpty()) {
            throw new ServiceException(ResultStatus.USER_PASSWORD_ERROR);
        }
        EnterpriseUser loginResult = auiList.get(0);

        String userStatus = loginResult.getStatus();
        if (!StringUtils.isEmpty(userStatus) && !userStatus.equals(getSystemMessages(SystemKey.USER_STATUS_NORMAL))) {
            throw new ServiceException(ResultStatus.ACCOUT_LOCKED);
        }
        return loginResult;
    }

    @Override
    public EnterpriseUser editPassword(EnterpriseUser userInfo, String oldPassword) {
        EnterpriseUserExample example = new EnterpriseUserExample();
        EnterpriseUserExample.Criteria cri = example.createCriteria();
        cri.andUser_NameEqualTo(userInfo.getUser_Name());
        cri.andWeb_PasswordEqualTo(SecretUtil.MD5(oldPassword));
        List<EnterpriseUser> userList = this.enterpriseUserDAO.selectByExample(example);
        if (userList == null || userList.isEmpty()) {
            throw new ServiceException(ResultStatus.USER_PASSWORD_ERROR);
        }
        // MD5加密
        userInfo.setWeb_Password(SecretUtil.MD5(userInfo.getWeb_Password()));
        userInfo.setLast_Update_Password_Time(new Date());
        enterpriseUserDAO.updateByPrimaryKeySelective(userInfo);
        return userInfo;
    }

    @Override
    public int updateByPrimaryKeySelective(Enterprise enterprise) {
        return enterpriseDAO.updateByPrimaryKeySelective(enterprise);
    }

    // 平台审核认证企业
    @Override
    public Integer authenticate(EnterpriseExt enterpriseExt) throws Exception {
        if (Constant.ENTERPRISE_CHECK_STATUS_PASS.equals(enterpriseExt.getAuthentication_State_Code())
                && StringUtils.isEmpty(enterpriseExt.getRemark())) {
            enterpriseExt.setRemark("认证通过");
        }
        this.editEnterprise(enterpriseExt);// 审核
        if (!Constant.ENTERPRISE_CHECK_STATUS_PASS.equals(enterpriseExt.getAuthentication_State_Code())) {
            return null;
        }
        // 查询企业下所有新注册角色账户
        Enterprise enterprise = this.enterpriseDAO.selectByPrimaryKey(enterpriseExt.getId());
        enterpriseExt.setRoleCode(Constant.NEWUSER_ROLE_CODE);
        enterpriseExt.setNo(enterprise.getNo());
        List<EnterpriseUserExt> userInfoExtList = enterpriseUserExtDAO.selectUserByEnterpriseAndRoleCode(enterpriseExt);
        if (ObjectUtils.isEmpty(userInfoExtList)) {
            return null;
        }
        // 查询默认角色
        EnterpriseRoleExample roleExample = new EnterpriseRoleExample();
        roleExample.createCriteria().andCodeEqualTo(Constant.DEFAULT_ROLE_CODE);
        List<EnterpriseRole> defaultRoleList = this.enterpriseRoleDAO.selectByExample(roleExample);
        // 如果没有默认角色
        if (ObjectUtils.isEmpty(defaultRoleList)) {
            return null;
        }
        // 将新注册用户绑定企业默认角色
        List<EnterpriseUserRoles> userRoleList = new ArrayList<EnterpriseUserRoles>();
        for (EnterpriseUserExt user : userInfoExtList) {
            EnterpriseUserRoles saveUserRoles = new EnterpriseUserRoles();
            saveUserRoles.setRole_Id(defaultRoleList.get(0).getId());
            saveUserRoles.setEnterprise_User_Id(user.getId());
            saveUserRoles.setCreate_User("系统");
            userRoleList.add(saveUserRoles);
        }
        this.bindUserRole(userRoleList);
        return null;
    }

    @Override
    public List<EnterpriseUserFee> queryEnterpriseUserFeeList(EnterpriseUserFee enterpriseUserFee) {
        EnterpriseUserFeeExample example = new EnterpriseUserFeeExample();
        EnterpriseUserFeeExample.Criteria criteria = example.createCriteria();
        if (enterpriseUserFee.getId() != null) {
            criteria.andIdEqualTo(enterpriseUserFee.getId());
        }
        if (StringUtils.isNotBlank(enterpriseUserFee.getEnterprise_No())) {
            criteria.andEnterprise_NoEqualTo(enterpriseUserFee.getEnterprise_No());
        }
        if (enterpriseUserFee.getEnterprise_User_Id() != null) {
            criteria.andEnterprise_User_IdEqualTo(enterpriseUserFee.getEnterprise_User_Id());
        }
        if (StringUtils.isNotBlank(enterpriseUserFee.getOperator())) {
            criteria.andOperatorEqualTo(enterpriseUserFee.getOperator());
        }
        if (StringUtils.isNotBlank(enterpriseUserFee.getTrade_Type_Code())) {
            criteria.andTrade_Type_CodeEqualTo(enterpriseUserFee.getTrade_Type_Code());
        }
        if (StringUtils.isNotBlank(enterpriseUserFee.getMessage_Type_Code())) {
            criteria.andMessage_Type_CodeEqualTo(enterpriseUserFee.getMessage_Type_Code());
        }
        if (StringUtils.isNotBlank(enterpriseUserFee.getCountry_Number())) {
            criteria.andCountry_NumberEqualTo(enterpriseUserFee.getCountry_Number());
        }
        return this.enterpriseUserFeeDAO.selectByExample(example);
    }

    @Override
    public List<SmsTemplate> querySmsTemplateList(SmsTemplateExt condition) {
        SmsTemplateExample example = new SmsTemplateExample();
        SmsTemplateExample.Criteria cri = example.createCriteria();
        if (!StringUtils.isEmpty(condition.getEnterprise_No())) {
            cri.andEnterprise_NoEqualTo(condition.getEnterprise_No());
        }
        if (!StringUtils.isEmpty(condition.getTemplate_Name())) {
            cri.andTemplate_NameLike("%" + condition.getTemplate_Name() + "%");
        }
        if (!StringUtils.isEmpty(condition.getTemplate_Type())) {
            cri.andTemplate_TypeEqualTo(condition.getTemplate_Type());
        }
        if (!StringUtils.isEmpty(condition.getApprove_Status())) {
            cri.andApprove_StatusEqualTo(condition.getApprove_Status());
        }
        if (condition.getId() != null) {
            cri.andIdEqualTo(condition.getId());
        }
        if (condition.getEnterprise_User_Id() != null) {
            cri.andEnterprise_User_IdEqualTo(condition.getEnterprise_User_Id());
        }
        example.setPagination(condition.getPagination());
        example.setOrderByClause(" id desc ");
        return smsTemplateDAO.selectByExamplePage(example);
    }

    @Override
    public void addSmsTemplate(SmsTemplate smsTemplate) {
        smsTemplate.setCreate_Date(new Date());
        smsTemplate.setTemplate_Content(smsTemplate.getTemplate_Content().trim());
        smsTemplateDAO.insert(smsTemplate);
    }

    @Override
    public void deleteSmsTemplate(List<Integer> ckIds, EnterpriseUser enterpriseUser) {
        SmsTemplateExample example = new SmsTemplateExample();
        SmsTemplateExample.Criteria cri = example.createCriteria();
        cri.andIdIn(ckIds);
        if (StringUtils.isNotEmpty(enterpriseUser.getEnterprise_No())) {
            cri.andEnterprise_NoEqualTo(enterpriseUser.getEnterprise_No());
        }
        if (enterpriseUser.getId() != null) {
            cri.andEnterprise_User_IdEqualTo(enterpriseUser.getId());
        }
        smsTemplateDAO.deleteByExample(example);
    }

    @Override
    public void importSmsTemplate(SmsTemplate entity, MultipartFile file) throws Exception {
        String redisKey = newThreadBefore(Constant.THREAD_TOTAL_IMPORT);//校验
        new Thread() {
            @Override
            public void run() {
                BufferedReader reader = null;
                InputStreamReader isr = null;
                try {
                    isr = new InputStreamReader(file.getInputStream());
                    reader = new BufferedReader(isr);
                    String textLine = "";
                    List<SmsTemplate> insertList = new ArrayList<>();// 插入列表
                    while ((textLine = reader.readLine()) != null) {
                        String[] lineArray = textLine.split("#");
                        if (lineArray.length >= 2) {
                            SmsTemplate smsTemplate = (SmsTemplate) entity.clone();
                            smsTemplate.setId(null);
                            smsTemplate.setTemplate_Name(lineArray[0]);
                            smsTemplate.setTemplate_Content(lineArray[1].trim());
                            insertList.add(smsTemplate);
                        }
                    }//while end
                    //插入数据
                    if (insertList.size() > 0) {
                        insertSmsTemplateList(insertList);
                    }
                    newThreadAfter(redisKey);
                } catch (Exception e) {
                    SuperLogger.error(e.getMessage(), e);
                } finally {
                    try {
                        isr.close();
                        reader.close();
                    } catch (IOException e) {
                        SuperLogger.error(e.getMessage(), e);
                    }
                }
            }

            private void insertSmsTemplateList(List<SmsTemplate> paramList) throws Exception {
                if (ObjectUtils.isNotEmpty(paramList)) {
                    if (paramList.size() > Constant.INSERT_MAX_LENGTH) {
                        List<SmsTemplate> insertList = paramList.subList(0, Constant.INSERT_MAX_LENGTH);//本次插入
                        List<SmsTemplate> nextList = paramList.subList(Constant.INSERT_MAX_LENGTH, paramList.size());//下次调用
                        smsTemplateDAO.insertList(insertList);
                        insertSmsTemplateList(nextList);//递归调用
                    } else {
                        smsTemplateDAO.insertList(paramList);
                    }
                }
            }
        }.start();

    }

    @Override
    public void editSmsTemplate(SmsTemplate smsTemplate) {
        SmsTemplateExample example = new SmsTemplateExample();
        SmsTemplateExample.Criteria cri = example.createCriteria();
        cri.andIdEqualTo(smsTemplate.getId());
        if (StringUtils.isNotEmpty(smsTemplate.getEnterprise_No())) {
            cri.andEnterprise_NoEqualTo(smsTemplate.getEnterprise_No());
        }
        if (smsTemplate.getEnterprise_User_Id() != null) {
            cri.andEnterprise_User_IdEqualTo(smsTemplate.getEnterprise_User_Id());
        }
        smsTemplate.setTemplate_Content(smsTemplate.getTemplate_Content().trim());
        smsTemplateDAO.updateByExampleSelective(smsTemplate, example);
    }

    @Override
    public SmsTemplate querySmsTemplateById(Integer id) {
        return smsTemplateDAO.selectByPrimaryKey(id);
    }

    @Override
    public void updateSmsTemplateExt(SmsTemplateExt smsTemplateExt) {
        smsTemplateDAO.updateByPrimaryKeySelective(smsTemplateExt);
    }

    @Override
    public List<SmsSignature> querySmsSignatureList(SmsSignatureExt condition) {
        SmsSignatureExample example = new SmsSignatureExample();
        SmsSignatureExample.Criteria cri = example.createCriteria();
        if (!StringUtils.isEmpty(condition.getEnterprise_No())) {
            cri.andEnterprise_NoEqualTo(condition.getEnterprise_No());
        }
        if (!StringUtils.isEmpty(condition.getSignature_Content())) {
            cri.andSignature_ContentLike("%" + condition.getSignature_Content() + "%");
        }
        if (!StringUtils.isEmpty(condition.getSignature_Type())) {
            cri.andSignature_TypeEqualTo(condition.getSignature_Type());
        }
        if (!StringUtils.isEmpty(condition.getApprove_Status())) {
            cri.andApprove_StatusEqualTo(condition.getApprove_Status());
        }
        if (!StringUtils.isEmpty(condition.getStatus_Code())) {
            cri.andStatus_CodeEqualTo(condition.getStatus_Code());
        }
        if (condition.getId() != null) {
            cri.andIdEqualTo(condition.getId());
        }
        example.setPagination(condition.getPagination());
        example.setOrderByClause(" id desc ");
        return smsSignatureDAO.selectByExamplePage(example);
    }

    @Override
    public void addSmsSignature(SmsSignature smsSignature) {
        smsSignature.setCreate_Date(new Date());
        smsSignature.setStatus_Code(Constant.STATUS_CODE_START);
        smsSignatureDAO.insert(smsSignature);
    }

    @Override
    public void editSmsSignature(SmsSignature smsSignature) {
        SmsSignatureExample example = new SmsSignatureExample();
        SmsSignatureExample.Criteria cri = example.createCriteria();
        cri.andIdEqualTo(smsSignature.getId());
        smsSignatureDAO.updateByExampleSelective(smsSignature, example);
    }

    @Override
    public void deleteSmsSignature(List<Integer> ckIds) {
        SmsSignatureExample example = new SmsSignatureExample();
        SmsSignatureExample.Criteria cri = example.createCriteria();
        cri.andIdIn(ckIds);
        smsSignatureDAO.deleteByExample(example);
    }

    @Override
    public SmsSignature querySmsSignatureById(Integer id) {
        return smsSignatureDAO.selectByPrimaryKey(id);
    }

    @Override
    public void updateSmsSignatureExt(SmsSignatureExt smsSignatureExt) {
        smsSignatureDAO.updateByPrimaryKeySelective(smsSignatureExt);
    }

    @Override
    public Enterprise queryEnterpriseByNo(String enterprise_no) {
        if (StringUtils.isEmpty(enterprise_no)) {
            return null;
        }
        EnterpriseExt condition = new EnterpriseExt();
        condition.setNo(enterprise_no);
        List<Enterprise> enterprisesList = this.queryEnterpriseList(condition);
        return ObjectUtils.isNotEmpty(enterprisesList) ? enterprisesList.get(0) : null;
    }

    @Override
    public void delEnterpriseUserFee(List<Integer> ckIds, EnterpriseUserExt userExt) {
        EnterpriseUserFeeExample example = new EnterpriseUserFeeExample();
        EnterpriseUserFeeExample.Criteria criteria = example.createCriteria();
        criteria.andIdIn(ckIds);
        if (userExt.getEnterpriseNoList() != null && !userExt.getEnterpriseNoList().isEmpty()) {
            criteria.andEnterprise_NoIn(userExt.getEnterpriseNoList());
        }
        this.enterpriseUserFeeDAO.deleteByExample(example);
    }

    @Override
    public List<EnterpriseUserFee> getEnterpriseUserFeeListAll(EnterpriseUserFee enterpriseUserFee) {
        EnterpriseUserFeeExample example = new EnterpriseUserFeeExample();
        EnterpriseUserFeeExample.Criteria criteria = example.createCriteria();
        if (enterpriseUserFee.getId() != null) {
            criteria.andIdEqualTo(enterpriseUserFee.getId());
        }
        if (StringUtils.isNotBlank(enterpriseUserFee.getEnterprise_No())) {
            criteria.andEnterprise_NoEqualTo(enterpriseUserFee.getEnterprise_No());
        }
        if (enterpriseUserFee.getEnterprise_User_Id() != null) {
            criteria.andEnterprise_User_IdEqualTo(enterpriseUserFee.getEnterprise_User_Id());
        }
        if (StringUtils.isNotBlank(enterpriseUserFee.getOperator())) {
            criteria.andOperatorEqualTo(enterpriseUserFee.getOperator());
        }
        if (StringUtils.isNotBlank(enterpriseUserFee.getTrade_Type_Code())) {
            criteria.andTrade_Type_CodeEqualTo(enterpriseUserFee.getTrade_Type_Code());
        }
        if (StringUtils.isNotBlank(enterpriseUserFee.getMessage_Type_Code())) {
            criteria.andMessage_Type_CodeEqualTo(enterpriseUserFee.getMessage_Type_Code());
        }
        if (StringUtils.isNotBlank(enterpriseUserFee.getCountry_Number())) {
            criteria.andCountry_NumberEqualTo(enterpriseUserFee.getCountry_Number());
        }
        return this.enterpriseUserFeeDAO.selectByExample(example);
    }

    @Override
    public void delEnterpriseUserFee(EnterpriseUserFee enterpriseUserFee) {
        EnterpriseUserFeeExample example = new EnterpriseUserFeeExample();
        EnterpriseUserFeeExample.Criteria criteria = example.createCriteria();
        if (null != enterpriseUserFee.getId()) {
            criteria.andIdEqualTo(enterpriseUserFee.getId());
        }
        if (StringUtils.isNotBlank(enterpriseUserFee.getEnterprise_No())) {
            criteria.andEnterprise_NoEqualTo(enterpriseUserFee.getEnterprise_No());
        }
        if (enterpriseUserFee.getEnterprise_User_Id() != null) {
            criteria.andEnterprise_User_IdEqualTo(enterpriseUserFee.getEnterprise_User_Id());
        }
        if (StringUtils.isNotBlank(enterpriseUserFee.getOperator())) {
            criteria.andOperatorEqualTo(enterpriseUserFee.getOperator());
        }
        if (StringUtils.isNotBlank(enterpriseUserFee.getTrade_Type_Code())) {
            criteria.andTrade_Type_CodeEqualTo(enterpriseUserFee.getTrade_Type_Code());
        }
        if (StringUtils.isNotBlank(enterpriseUserFee.getMessage_Type_Code())) {
            criteria.andMessage_Type_CodeEqualTo(enterpriseUserFee.getMessage_Type_Code());
        }
        if (StringUtils.isNotBlank(enterpriseUserFee.getCountry_Number())) {
            criteria.andCountry_NumberEqualTo(enterpriseUserFee.getCountry_Number());
        }
        this.enterpriseUserFeeDAO.deleteByExample(example);
    }

    @Override
    public void addEnterpriseUserFeeList(List<EnterpriseUserFee> list) {
        List<EnterpriseUserFee> insertList = new ArrayList<EnterpriseUserFee>();
        Enterprise enterprise = DatabaseCache.getEnterpriseByNo(list.get(0).getEnterprise_No());
        for (EnterpriseUserFee entity : list) {
            if (entity.getUnit_Price() == null) {
                continue;
            }
            entity.setCreate_Date(new Date());
            insertList.add(entity);
        }
        EnterpriseUserFeeExample example = new EnterpriseUserFeeExample();
        EnterpriseUserFeeExample.Criteria criteria = example.createCriteria();
        criteria.andEnterprise_NoEqualTo(insertList.get(0).getEnterprise_No());
        criteria.andCountry_NumberEqualTo(insertList.get(0).getCountry_Number());
        criteria.andEnterprise_User_IdEqualTo(list.get(0).getEnterprise_User_Id());
        this.enterpriseUserFeeDAO.deleteByExample(example);
        this.enterpriseUserFeeDAO.insertList(insertList);
    }

    @Override
    public SqlStatisticsEntity queryEnterpriseListTotalData(EnterpriseExt condition) {
        EnterpriseExample example = assemblyEnterpriseConditon(condition);
        return this.enterpriseExtDAO.statisticsExtByExample(example);
    }

    @Override
    public List<EnterpriseUser> getEnterpriseUserByAgentNo(String agentNo) {
        if (StringUtils.isEmpty(agentNo)) {
            return null;
        }
        List<String> enterpriseNoList = new ArrayList<>();
        EnterpriseExt eBean = new EnterpriseExt();
        eBean.setAgent_No(agentNo);
        List<Enterprise> enterpriseList = this.queryEnterpriseList(eBean);
        for (Enterprise enterprise : enterpriseList) {
            enterpriseNoList.add(enterprise.getNo());
        }
        if (enterpriseNoList.size() < 1) {
            enterpriseNoList.add("-1");
        }
        EnterpriseUserExt eUser = new EnterpriseUserExt();
        eUser.setEnterpriseNoList(enterpriseNoList);
        return this.queryEnterpriseUserList(eUser);
    }

    @Override
    public int deleteEnterpriseLimit(List<Integer> ids) {
        if (ObjectUtils.isEmpty(ids)) {
            throw new BaseException("请选择权限");
        }
        return ids.stream().reduce(0, (row, id) -> {
            EnterpriseLimit limit = this.enterpriseLimitDAO.selectByPrimaryKey(id);
            EnterpriseLimitExample deleteExample = new EnterpriseLimitExample();
            deleteExample.createCriteria().andCodeLike(limit.getCode() + "%");
            return this.enterpriseLimitDAO.deleteByExample(deleteExample);
        }, Integer::sum);
    }

    private void isExistedEnterpriseUserFee(EnterpriseUserFee enterpriseUserFee) {
        EnterpriseUserFee fee = new EnterpriseUserFee();
        fee.setEnterprise_No(enterpriseUserFee.getEnterprise_No());
        fee.setCountry_Number(enterpriseUserFee.getCountry_Number());
        fee.setEnterprise_User_Id(enterpriseUserFee.getEnterprise_User_Id());
        fee.setMessage_Type_Code(enterpriseUserFee.getMessage_Type_Code());
        fee.setOperator(enterpriseUserFee.getOperator());
        fee.setTrade_Type_Code(enterpriseUserFee.getTrade_Type_Code());
        List<EnterpriseUserFee> enterpriseUserFees = queryEnterpriseUserFeeList(fee);
        if (enterpriseUserFees.size() > 0) {
            throw new ServiceException(ResultStatus.ENTERPRISENO_USER_FEE_EXIST);
        }
    }

    @Override
    public void addEnterpriseUserFee(EnterpriseUserFee enterpriseUserFee) {
        isExistedEnterpriseUserFee(enterpriseUserFee);
        EnterpriseUser enterpriseUser = DatabaseCache
                .getEnterpriseUserCachedById(enterpriseUserFee.getEnterprise_User_Id());
        enterpriseUserFee.setEnterprise_No(enterpriseUser.getEnterprise_No());
        enterpriseUserFee.setCreate_Date(new Date());
        this.enterpriseUserFeeDAO.insert(enterpriseUserFee);
    }

    @Override
    public void editEnterpriseUserFee(EnterpriseUserFee enterpriseUserFee) {
        this.enterpriseUserFeeDAO.updateByPrimaryKeySelective(enterpriseUserFee);
    }

    @Override
    public void exportEnterpriseList(EnterpriseExt bean, ExportFileExt exportFile) {
        new Thread(() -> {
            int pageSize = DatabaseCache.getIntValueBySortCodeAndCode("sys_performance_setup", "export_file_size",5000);
            Pagination firstPage = new Pagination(1, pageSize);
            List<Map<String, Object>> beanList;
            exportFile.setBatch_Id(CodeUtil.buildMsgNo());
            while (true) {
                bean.setPagination(firstPage);
                beanList = queryEnterpriseListForExportPage(bean);
                if (beanList == null || beanList.isEmpty()) {
                    break;
                }
                exportEnterpriseExcel(beanList, exportFile);
                if (firstPage.getPageIndex() == firstPage.getPageCount()) {
                    break;
                }
                firstPage = new Pagination(firstPage.getPageIndex() + 1, pageSize);
            }
        }).start();
    }

    @Override
    public void exportEnterpriseUserList(EnterpriseUserExt bean, ExportFileExt exportFile) {
        new Thread(() -> {
            int pageSize = DatabaseCache.getIntValueBySortCodeAndCode("sys_performance_setup", "export_file_size",5000);
            Pagination firstPage = new Pagination(1, pageSize);
            List<Map<String, Object>> beanList;
            exportFile.setBatch_Id(CodeUtil.buildMsgNo());
            while (true) {
                bean.setPagination(firstPage);
                beanList = queryEnterpriseUserListForExportPage(bean);
                if (beanList == null || beanList.isEmpty()) {
                    break;
                }
                exportEnterpriseUserExcel(beanList, exportFile);
                if (firstPage.getPageIndex() == firstPage.getPageCount()) {
                    break;
                }
                firstPage = new Pagination(firstPage.getPageIndex() + 1, pageSize);
            }
        }).start();
    }


    @Override
    public void initUserProperties(EnterpriseUser old, EnterpriseUserExt newUser) {
        //字段
        doUserField(old,newUser);
        //属性配置
        doUserProperties(old,newUser);
        //资费配置
        doUserFee(old,newUser);
    }

    @Override
    public List<Enterprise> queryAddEnterpriseCount() {
        EnterpriseExample example = new EnterpriseExample();
        example.createCriteria().andCreate_DateGreaterThan(DateTime.getDate(DateTime.getCurrentDayMinDate()));
        return enterpriseDAO.selectByExample(example);
    }

    // ==================== 合作期限台账 v4.2 ====================

    @Override
    public List<CooperationPeriod> queryCooperationPeriodList(CooperationPeriodExt condition) {
        CooperationPeriodExample example = new CooperationPeriodExample();
        CooperationPeriodExample.Criteria cri = example.createCriteria();
        if (!StringUtils.isEmpty(condition.getEnterprise_No())) {
            cri.andEnterprise_NoEqualTo(condition.getEnterprise_No());
        }
        if (!StringUtils.isEmpty(condition.getProduct_No())) {
            cri.andProduct_NoLike("%" + condition.getProduct_No() + "%");
        }
        if (!StringUtils.isEmpty(condition.getStatus_Code())) {
            cri.andStatus_CodeEqualTo(condition.getStatus_Code());
        }
        if (condition.getId() != null) {
            cri.andIdEqualTo(condition.getId());
        }
        example.setPagination(condition.getPagination());
        example.setOrderByClause(" id desc ");
        return cooperationPeriodDAO.selectByExamplePage(example);
    }

    @Override
    public CooperationPeriod queryCooperationPeriodById(Integer id) {
        return cooperationPeriodDAO.selectByPrimaryKey(id);
    }

    @Override
    public CooperationPeriod addCooperationPeriod(CooperationPeriod data) {
        // 校验：企业编号必填
        if (StringUtils.isEmpty(data.getEnterprise_No())) {
            throw new ServiceException("企业编号不能为空");
        }
        // 校验：开始日期 < 结束日期
        if (data.getStart_Date() != null && data.getEnd_Date() != null) {
            if (data.getStart_Date().after(data.getEnd_Date())) {
                throw new ServiceException("开始日期必须小于结束日期");
            }
        }
        // 校验：企业资质是否过期
        EnterpriseExample entExample = new EnterpriseExample();
        entExample.createCriteria().andNoEqualTo(data.getEnterprise_No()).andStatusNotEqualTo(AccountStatus.DELETE.toString());
        List<Enterprise> enterprises = enterpriseDAO.selectByExample(entExample);
        if (enterprises != null && !enterprises.isEmpty()) {
            Enterprise enterprise = enterprises.get(0);
            if (enterprise.getQualification_Expiry_Date() != null && enterprise.getQualification_Expiry_Date().before(new Date())) {
                throw new ServiceException("企业资质已过期，无法新增合作期限");
            }
        }
        data.setStatus_Code(StringUtils.isEmpty(data.getStatus_Code()) ? "1" : data.getStatus_Code());
        data.setCreate_Date(new Date());
        cooperationPeriodDAO.insert(data);
        return data;
    }

    @Override
    public void editCooperationPeriod(CooperationPeriodExt data) {
        // 校验：开始日期 < 结束日期
        if (data.getStart_Date() != null && data.getEnd_Date() != null) {
            if (data.getStart_Date().after(data.getEnd_Date())) {
                throw new ServiceException("开始日期必须小于结束日期");
            }
        }
        cooperationPeriodDAO.updateByPrimaryKeySelective(data);
    }

    @Override
    public void terminateCooperationPeriod(Integer id) {
        CooperationPeriod record = new CooperationPeriod();
        record.setId(id);
        record.setStatus_Code("0"); // 终止
        cooperationPeriodDAO.updateByPrimaryKeySelective(record);
    }

    // ==================== 投诉处理 v4.4 ====================

    @Override
    public List<Complaint> queryComplaintList(ComplaintExt condition) {
        ComplaintExample example = new ComplaintExample();
        ComplaintExample.Criteria cri = example.createCriteria();
        if (!StringUtils.isEmpty(condition.getEnterprise_No())) {
            cri.andEnterprise_NoEqualTo(condition.getEnterprise_No());
        }
        if (!StringUtils.isEmpty(condition.getProduct_No())) {
            cri.andProduct_NoLike("%" + condition.getProduct_No() + "%");
        }
        if (!StringUtils.isEmpty(condition.getPhone_No())) {
            cri.andPhone_NoLike("%" + condition.getPhone_No() + "%");
        }
        if (!StringUtils.isEmpty(condition.getComplaint_Source())) {
            cri.andComplaint_SourceEqualTo(condition.getComplaint_Source());
        }
        if (!StringUtils.isEmpty(condition.getHandle_Status())) {
            cri.andHandle_StatusEqualTo(condition.getHandle_Status());
        }
        if (condition.getId() != null) {
            cri.andIdEqualTo(condition.getId());
        }
        example.setPagination(condition.getPagination());
        example.setOrderByClause(" id desc ");
        return complaintExtDAO.selectByExamplePage(example);
    }

    @Override
    public Complaint queryComplaintById(Integer id) {
        return complaintExtDAO.selectByPrimaryKey(id);
    }

    @Override
    public Complaint addComplaint(Complaint data) {
        // 校验：企业编号必填
        if (StringUtils.isEmpty(data.getEnterprise_No())) {
            throw new ServiceException("企业编号不能为空");
        }
        // 校验：投诉号码必填
        if (StringUtils.isEmpty(data.getPhone_No())) {
            throw new ServiceException("投诉号码不能为空");
        }
        // 校验：投诉内容必填
        if (StringUtils.isEmpty(data.getComplaint_Content())) {
            throw new ServiceException("投诉内容不能为空");
        }
        data.setHandle_Status(StringUtils.isEmpty(data.getHandle_Status()) ? "0" : data.getHandle_Status());
        data.setCreate_Date(new Date());
        complaintExtDAO.insert(data);
        return data;
    }

    @Override
    public void editComplaint(ComplaintExt data) {
        complaintExtDAO.updateByPrimaryKeySelective(data);
    }

    @Override
    public void handleComplaint(ComplaintExt data) {
        if (data.getId() == null) {
            throw new ServiceException("投诉ID不能为空");
        }
        // 处理投诉：更新状态/处理人/处理结果/处理时间
        Complaint record = new Complaint();
        record.setId(data.getId());
        record.setHandle_Status(StringUtils.isEmpty(data.getHandle_Status()) ? "1" : data.getHandle_Status());
        record.setHandle_User_Id(data.getHandle_User_Id());
        record.setHandle_Result(data.getHandle_Result());
        record.setHandle_Date(data.getHandle_Date() != null ? data.getHandle_Date() : new Date());
        complaintExtDAO.updateByPrimaryKeySelective(record);
    }

    @Override
    public void deleteComplaintBatch(List<Integer> ids) {
        if (ids == null || ids.isEmpty()) {
            return;
        }
        ComplaintExample example = new ComplaintExample();
        example.createCriteria().andIdIn(ids);
        complaintExtDAO.deleteByExample(example);
    }

    // ==================== 投诉统计 v4.8 ====================

    @Override
    public Map<String, Integer> countComplaintByEnterprise() {
        List<Complaint> allComplaints = complaintExtDAO.selectByExample(new ComplaintExample());
        Map<String, Integer> result = new HashMap<>();
        for (Complaint c : allComplaints) {
            String key = StringUtils.isEmpty(c.getEnterprise_No()) ? "未知" : c.getEnterprise_No();
            result.put(key, result.getOrDefault(key, 0) + 1);
        }
        return result;
    }

    @Override
    public Map<String, Integer> countComplaintBySource() {
        List<Complaint> allComplaints = complaintExtDAO.selectByExample(new ComplaintExample());
        Map<String, Integer> result = new HashMap<>();
        for (Complaint c : allComplaints) {
            String key = StringUtils.isEmpty(c.getComplaint_Source()) ? "未知" : c.getComplaint_Source();
            result.put(key, result.getOrDefault(key, 0) + 1);
        }
        return result;
    }

    @Override
    public Map<String, Integer> countComplaintByStatus() {
        List<Complaint> allComplaints = complaintExtDAO.selectByExample(new ComplaintExample());
        Map<String, Integer> result = new HashMap<>();
        for (Complaint c : allComplaints) {
            String key = StringUtils.isEmpty(c.getHandle_Status()) ? "未知" : c.getHandle_Status();
            result.put(key, result.getOrDefault(key, 0) + 1);
        }
        return result;
    }

    // ==================== 系统配置 v4.9 ====================

    @Override
    public void updateSystemEnvConfig(String code, String value) {
        CodeExample example = new CodeExample();
        example.createCriteria().andSort_CodeEqualTo("system_env").andCodeEqualTo(code);
        List<Code> configs = codeDAO.selectByExample(example);
        if (configs != null && !configs.isEmpty()) {
            Code record = configs.get(0);
            record.setValue(value);
            codeDAO.updateByPrimaryKeySelective(record);
        } else {
            throw new ServiceException("配置项不存在：" + code);
        }
    }

    // ==================== 拒收记录 v4.6 ====================

    @Override
    public List<UnsubscribeLog> queryUnsubscribeLogList(UnsubscribeLogExt condition) {
        UnsubscribeLogExample example = new UnsubscribeLogExample();
        UnsubscribeLogExample.Criteria cri = example.createCriteria();
        if (!StringUtils.isEmpty(condition.getEnterprise_No())) {
            cri.andEnterprise_NoEqualTo(condition.getEnterprise_No());
        }
        if (!StringUtils.isEmpty(condition.getProduct_No())) {
            cri.andProduct_NoLike("%" + condition.getProduct_No() + "%");
        }
        if (!StringUtils.isEmpty(condition.getPhone_No())) {
            cri.andPhone_NoLike("%" + condition.getPhone_No() + "%");
        }
        if (condition.getId() != null) {
            cri.andIdEqualTo(condition.getId());
        }
        example.setPagination(condition.getPagination());
        example.setOrderByClause(" id desc ");
        return unsubscribeLogExtDAO.selectByExamplePage(example);
    }

    @Override
    public UnsubscribeLog queryUnsubscribeLogById(Long id) {
        return unsubscribeLogExtDAO.selectByPrimaryKey(id);
    }

    private String getPlainPassword(String encryptPassword) {
        //rsa解密
        String passwordPrivateKey = DatabaseCache.getStringValueBySystemEnvAndCode("password_private_key", "");
        String plainText = null;
        if (StringUtils.isNotBlank(passwordPrivateKey)) {
            plainText = CertificateUtil.decryptByPrivateKey(encryptPassword, passwordPrivateKey);
            if (StringUtils.isEmpty(plainText)) {
                SuperLogger.error("密码解密错误，请检查私钥");
                throw new ServiceException(ResultStatus.ERROR);
            }
        }
        return plainText;
    }
}

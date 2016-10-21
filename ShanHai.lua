---------------------------------------	����˵��	---------------------------------------
--[[

�������: ɽ��ʦ
����ʱ��: 2016.03.04
��ϵ��ʽ: 1915025270 (QQ)
�����֮����������,�緢��BUG�����й�����������ϵ�������

--]]


--��ʱ��ȡ�ļ�[�ڲ�����]
function readfile(path,test)
	f = io.open(path,"r")
	if f == null then 
		return null 
	end 
	ret = f:read("*all")
	f:close()
	if test ==nil then
		os.remove(path)
	end 
	return ret
end 

--��ʱ�ļ�
function TempFile(filename)
	return "/sdcard/" ..filename ..".txt"
end 

--�ƶ���[�ڲ�����]
function MoveTable(oldarr)
	local newarr = {}
	local i=1
	for k,v in ipairs(oldarr) do
		newarr[k] = v
		print(i,v,newarr[i])
		i=i+1
	end 
	return newarr
end 

function print(str)
	LuaAuxLib.TracePrint(str)
end 

QMPlugin={}
function QMPlugin.match(str,format)
	return str:match(format)
end
function QMPlugin.gsub(str,f,s)
	return str:gsub(f,s)
end
---------------------------------------	�ַ���\���鴦��	---------------------------------------

--��������
function QMPlugin.Filter(arr,include,type)
	local tarr = {}
	for k,v in ipairs(arr) do
		if type == true or type == null then 
			if string.find(v, include) == nil then
				table.insert(tarr, v)
			end
		else 
			if string.find(v, include) ~= nil then
				table.insert(tarr, v)
			end
		end 
	end
	return tarr
end 

--��������
function QMPlugin.Sort(arr,comp)
	local t = {}
	local j = 1
	tarr = MoveTable(arr)
	table.sort(tarr)
	if comp == true or comp == null then
		return tarr
	else
		for i = #tarr ,1,-1 do 
			t[j] = tarr[i]
			j=j+1
		end 
		return t
	end
end 

--ɾ������Ԫ��
function QMPlugin.Remove(arr,pos)
	tarr = MoveTable(arr)
	table.remove(tarr,pos+1)
	return tarr
end 

--��������Ԫ��
function QMPlugin.insert(arr,pos,value)
	tarr = MoveTable(arr)
	table.insert(tarr,pos+1,value)
	return tarr
end 

--����ǰ���ַ�
local LTrimEx = function (str,filt)
	local retstr = ""
	for i=1, string.len(str) do 
		if string.find(filt,string.sub(str,i,i)) == null then
			retstr = string.sub(str,i,-1)
			break
		end 
	end 
	return retstr
end 
QMPlugin.LTrimEx = LTrimEx


--���˺��ַ�
local RTrimEx = function (str,filt)
	local retstr = ""
	for i=string.len(str), 1, -1 do 
		if string.find(filt,string.sub(str,i,i)) == null then
			retstr = string.sub(str,1,i)
			break
		end 
	end 
	return retstr
end 
QMPlugin.RTrimEx = RTrimEx

--����ǰ������ַ�
function QMPlugin.TrimEx(str,filt)
	local tmpstr
	tmpstr = LTrimEx(str,filt)
	return RTrimEx(tmpstr,filt)
end 

--ɾ��ָ�������ַ�
function QMPlugin.DelPartStr(str,sval,eval)
	local LStr = string.sub(str,1,sval-1)
	local RStr = string.sub(str,eval+1,-1)
	local RetStr = LStr ..RStr
	return RetStr
end 

--ɾ��ָ���ַ�
function QMPlugin.DelFilStr(str,filter)
	local RetStr,TmpLStr,TmpRStr
	RetStr = str
	while true do
		s,e = string.find(RetStr,filter,e)
		if s~= nil then
			TmpLStr = string.sub(RetStr,1,s-1)
			TmpRStr = string.sub(RetStr,e+1,-1)
			RetStr = TmpLStr ..TmpRStr
		else 
			break
		end 
	end
	return RetStr
end 

--����ȥ�� 
function QMPlugin.RemoveDup(tbl)
	local a = {}
	local b = {}
	for _,v in ipairs(tbl) do
		a[v] = 0
	end
	for k,v in pairs(a) do
		table.insert(b, k)
	end
	return b
end 

--����Ԫ�ظı�λ�� 
function QMPlugin.ChangePos(arr,a,b)
	local tmptbl = arr
	local tmpval = arr[a+1]
	table.remove(tmptbl,a+1)
	table.insert(tmptbl,b+1,tmpval)
	return tmptbl
end 

---------------------------------------	���������	---------------------------------------

--��Χ����� 
function QMPlugin.RndEx(min,max)
	return math.random(min,max)
end 

--���ȡ�߼�ֵ
function QMPlugin.RndBool()
	local tmpnum = math.random(2)-1
	if tmpnum == 0 then
		return true
	else 
		return false
	end
end 

--���ȡ�������� 
function QMPlugin.RandArray(arr)
	local index
	index = math.random(1,#arr)
	return arr[index]
end 

--������ɲ��ظ�����  [���ߣ�С��]
function QMPlugin.RanDiffarr(arr,num)
	if num == null or num > #arr then num = #arr end
	local Lines = {}
	for _ = 1,num do
		local n = math.random(#arr)
		Lines[#Lines + 1] = arr[n]
		table.remove(arr,n)
	end
	return Lines
end
---------------------------------------	�ļ�����	---------------------------------------

--��ȡ·���а������ļ���׺
function QMPlugin.GetFileType(path)
	s,e = string.find(path,"%.")
	return string.sub(path,s+1 ,-1)
end 

--��ȡ·���а������ļ��� 
function QMPlugin.GetFileName(path)
	path = "/" .. path
	local ret
	for w in string.gmatch(path, "/([^/]+)") do
		ret = w
	end
	return ret
end 

--������������ļ�
function QMPlugin.GetTempFile(Path, Prefix, Postfix, Lenght)
	local RndText,RetText
	for i=1,Lenght do 
		if RndText == nil then
			RndText = math.random(Lenght)
		else 
			RndText = RndText .. math.random(Lenght)
		end 
	end 
	RetText = Path .. Prefix .. RndText .. Postfix
	local f = io.open(RetText,"a+")
	f:close()
end 

--����Ŀ¼
function QMPlugin.ScanPath(path,filter)
	local tmppath = TempFile("scan")
	local ret = {}
	local ret1 = {}
	os.execute("ls " .. path .." > " ..tmppath)
	local f = io.open(tmppath)
	for n in f:lines() do 
		if string.find(n,"%.") ~= null then
			table.insert(ret,n)
		else 
			table.insert(ret1,n)
		end 
	end
	f:close()
	if filter == 1 then
		return ret
	else 
		return ret1
	end 
end 
--[[�����ļ����������ļ�  [���ߣ�С��]
function QMPlugin.Listall(path)
	local localpath = temppath().."listall"
	os.execute(string.format("ls -al %s > %s",path,localpath))
	local listall = readfile(localpath)
	return listall
end
--]]

--�����ļ�Ȩ�� 
function QMPlugin.Chmod(path,per)
	if per == 0 then
		os.execute("chmod 666 " ..path) 
	elseif per == 1 then
		os.execute("chmod 444 " ..path)
	end 
end 
--[[�޸�Ȩ�ޣ�����ΪȨ�ޡ��ļ�·�����޷���ֵ  [���ߣ�С��]
function QMPlugin.ChangeFolder(per,dirname)
	pcall(
	function()
	    os.execute("chmod "..per.." ".. dirname)
	end)
end
--]]

--�����ļ�Ȩ��[��ǿ]
function QMPlugin.ChmodEx(path,per)
	return os.execute("chmod " ..per.." "..path)
end 

--д���ݵ�ָ���� 
function QMPlugin.WriteFileLine(path,line,str)
	local t={}
	f = io.open(path,"a+")
	local text = f:read("*all")
	for i in f:lines() do
		table.insert(t,i)
	end
	table.insert(t,line,str)
	f:close()
	f = io.open(path,"w")
	for _,v in ipairs(t) do 
		f:write(v.."\r\n")
	end 
	f:close()
end 

--ɾ��ָ��Ŀ¼��ָ����׺���ļ�  [���ߣ�С��]
function QMPlugin.FindFileDelete(findpath,filename)
	os.execute(string.format("find %s -name '%s' | xargs rm -rf",findpath,filename))
end

---------------------------------------	�豸�������	---------------------------------------

--��ȡMAC��ַ
function QMPlugin.GetMAC()
	local path = TempFile("MACRecord")
	os.execute("cat /sys/class/net/wlan0/address > " .. path )
	local r = readfile(path)
	return r
end

--�������뷨
function QMPlugin.SetIME(pattern)
	if pattern == 0 then		--�ٶ�С�װ�
		os.execute("ime set com.baidu.input_mi/.ImeService ")
	elseif pattern == 1 then  	--Ѷ��
		os.execute("ime set com.iflytek.inputmethod/.FlyIME")
	elseif pattern == 2 then	--�ȸ�
		os.execute("ime set com.google.android.inputmethod.pinyin")
	elseif pattern == 3 then	--����
		os.execute("ime set com.xinshuru.inputmethod/.FTInputService")
	elseif pattern == 4 then	--GO���뷨
		os.execute("ime set com.jb.gokeyboard/.GoKeyboard")
	elseif pattern == 5 then	--�������뷨
		os.execute("ime set com.cootek.smartinputv5.tablet/com.cootek.smartinput5.TouchPalIME")
	elseif pattern == 6 then	--QQƴ��
		os.execute("ime set com.tencent.qqpinyin/.QQPYInputMethodService ")
	elseif pattern == 7 then	--�ٶ����뷨
		os.execute("ime set com.baidu.input/.ImeService")
	elseif pattern == 8 then	--�������뷨
		os.execute("ime set com.komoxo.octopusime/com.komoxo.chocolateime.LatinIME")
	elseif pattern ==9 then 	--���ð����������뷨
		os.execute("ime set com.cyjh.mobileanjian/.input.inputkb")
	elseif pattern == 10 then	--�����ѹ����뷨
		os.execute("ime set com.sohu.inputmethod.sogou/.SogouIME")
	end 
end 	
--[[�л����뷨  [���ߣ�С��]
--����:���뷨����,��sogou��baidu...
function QMPlugin.Switchinput(name)
	name = name:lower()
	if name == "sogou" then
		os.execute("ime set com.sohu.inputmethod.sogou/.SogouIME")--�ѹ����뷨
	elseif name == "baidu" then
		os.execute("ime set com.baidu.input/.ImeService")--�ٶ����뷨
	elseif name == "baidu_miv6" then
		os.execute("ime set com.baidu.input_miv6/.ImeService")--С��v6�ٶ����뷨
	elseif name == "qq" then
		os.execute("ime set com.tencent.qqpinyin/.QQPYInputMethodService")--QQƴ�����뷨
	elseif name == "chumo" then
		os.execute("ime set net.aisence.Touchelper/.IME")--�����������뷨
	elseif name == "jiaoben" then
		os.execute("ime set com.scriptelf/.IME")--�ű��������뷨
	elseif name == "anjian" then
		os.execute("ime set com.cyjh.mobileanjian/.input.inputkb")--�����������뷨
	elseif name == "xscript" then
		os.execute("ime set com.surcumference.xscript/.Xkbd")--xscript���뷨
	elseif name == "tc" then
		os.execute("ime set com.xxf.tc.Activity/api.input.TC_IME")--TC���뷨
	elseif name == "zhangyu" then
		os.execute("ime set com.tongmo.octopus.helper/com.tongmo.octopus.api.OctopusIME")--�������뷨
	elseif name == "chudong" then
		os.execute("ime set com.touchsprite.android/.core.TSInputMethod")--�����������뷨
	end
end
--]]

--��װapp
function QMPlugin.Install(path)
	os.execute("pm install -r " .. string.format("%s",path) )
end 

--ж��app
function QMPlugin.Uninstall(PackageName)
	os.execute("pm uninstall  " .. string.format("%s",PackageName) )
end 
--[[��Ĭ��װapk  [���ߣ�С��]
function QMPlugin.Install(packagepath)
	os.execute(string.format("pm install %s",packagepath))
end
--��Ĭж��apk
function QMPlugin.Uninstall(packagename)
	os.execute(string.format("pm uninstall %s",packagename))
end
--]]

--��ȡ֪ͨ����Ϣ
function QMPlugin.GetNotification(PackageName)
	local s,e
	local path = TempFile("Notification")
	os.execute("dumpsys notification > " ..path )
	local text = readfile(path)
	repeat
		s,e = string.find(text,"pkg=[^ ]+",e)
		pkgname = string.sub(text,s+4,e)
		if pkgname == PackageName then
			s,e = string.find(text,"tickerText=[^\r\n]+",e)
			tickertext = string.sub(text,s+11,e)
			return tickertext
		end 
	until s == null
end 
--[[��ȡ֪ͨ����Ϣ  [���ߣ�С��]
function QMPlugin.Notification(pkgname)
		local localpath = temppath().."Notification"
		os.execute("dumpsys notification > "..localpath)
		xw = readfile(localpath)
		pkg = 1
		notifications = ""
		repeat
			_,pkg = xw:find("pkg="..pkgname,pkg)
			_,text = xw:find("tickerText=",pkg)
			content,_ = xw:find("contentView=",text)
			notification = xw:sub(text + 1,content - 8)
			if notification ~= "null" then
				notifications = notifications..notification.." \n"
			end
		until pkg == nil
		if #notifications == 0 then
			notifications= "null"
		end
		return notifications
end
--]]

--��ȡ����ip
function QMPlugin.GetIP()
	local path  = TempFile("ip")
	os.execute("curl --connect-timeout 8 www.1356789.com > "..path)
	local ret = readfile(path)
	return ret:match("%d+%.%d+%.%d+%.%d+")
end
--[[��ȡ����ip��ַ  [���ߣ�С��]
function QMPlugin.GetIP()
	return LuaAuxLib.URL_Operation("http://52xiaov.com/getipinfo.php"):match("ip:(.-)<br/>")
end
--]]

--��ȡ��ǰӦ�ð����������
function QMPlugin.GetTopActivity()
	local path = TempFile ("app")
	os.execute("dumpsys activity top >" .. path)
	return string.match(readfile(path),"ACTIVITY ([^ ]+)")
end 
--[[��ȡǰ̨Ӧ�ð����������  [���ߣ�С��]
function QMPlugin.TopActivityName() 
	local localpath = temppath().."TopActivityName"
	os.execute("dumpsys activity top | grep ACTIVITY > "..localpath)
	local TopActivity = readfile(localpath)
	return TopActivity:match("ACTIVITY (.-) ")
end
--]]

--��ȡ�豸�е�Ӧ��
function QMPlugin.GetAppList(type)
	local path = TempFile ("applist")
	if type == 0 then 
		type = " -3 >"
	elseif type == 1 then
		type = " -s >"
	end 
	os.execute("pm list packages "..type..path)
	local ret ={}
	for k in string.gmatch(readfile(path),"[^\r\n]+") do 
		table.insert(ret,k)
	end 
	return ret
end 
--[[��ȡ�Ѱ�װ����  [���ߣ�С��]
function QMPlugin.ListPackage(issystem)
	local localpath = temppath().."ListPackage"
	os.execute("pm list package -f > "..localpath)
	local ReadContent = readfile(localpath)
	local systempackage={}
	local userpackage={}
	for i in ReadContent:gmatch("(.-)\n(.-)") do
		local _,_,savepath,packagename = i:find("package:/(.-)/.-=(.+)")
		if savepath == "system" then
			systempackage[#systempackage+1]=packagename
		elseif savepath == "data" then
			userpackage[#userpackage+1]=packagename
		end
	end
	issystem = tostring(issystem)
	if issystem == "true" then
		return systempackage
	elseif issystem == "false" then
		return userpackage
	else
		for _,i in pairs(userpackage) do
			table.insert(systempackage,i)
		end
		return systempackage
	end
end
--]]

--�ر�\����wifi
function QMPlugin.ControlWifi(mode)
	if mode == true then
		os.execute("svc wifi enable")
	else 
		os.execute("svc wifi disable")
	end 
end 

--�ر�\������������
function QMPlugin.ControlData(mode)
	if mode == true then
		os.execute("svc data enable")
	else 
		os.execute("svc data disable")
	end 
end 

--���wifi�Ƿ���
function QMPlugin.IsConnectWifi()
	local path = TempFile ("wifi")
	os.execute("dumpsys wifi > "..path)
	local f = io.open(path,"r")
	local ret = f:read("*line")
	f:close()
	if string.find(ret,"disabled") == null then
		return true
	else 
		return false
	end 
end 

--��ȡ��׿ϵͳ�汾��
function QMPlugin.GetAndroidVer()
	local localpath = TempFile ("AndroidVer")
	os.execute(string.format("getprop ro.build.version.release > %s",localpath))
	return readfile(localpath)
end 

--�����ֻ�
function QMPlugin.Reboot()
	os.execute("reboot")
end 

--�ػ�
function QMPlugin.ShutDown()
	os.execute("reboot -p")
end 

--�ж��豸�Ƿ��������
function QMPlugin.IsVM()
	local path = TempFile ("IsVM") 
	os.execute("cat /proc/cpuinfo > " .. path)
	retinfo = readfile(path)
	s = string.find(ret,"model name")
	if s == nil then
		ret = false
	else
		ret =true
	end 
	return ret
end 

--�жϳ��״̬ 
function QMPlugin.GetBatteryState()
	local state
	local path = TempFile("Battery")
	os.execute("dumpsys battery > " ..path)
	local ret = readfile(path)
	if string.find(ret,"AC powered: true") then
		state = 1
	elseif string.find(ret,"USB powered: true") then
		state = 2
	elseif string.find(ret,"Wireless powered: true") then
		state = 3
	else 
		state = 0
	end 
	return state
end 

--�ж������Ƿ��� 
function QMPlugin.IsBluetooth()
	local path = TempFile("Bluetooth")
	os.execute("getprop > " ..path)
	local ret = readfile(path)
	if string.find(ret,"%[bluetooth.status%]: %[on%]") then
		return true
	else 
		return false
	end 
end 

--ָ��APP����ַ  [���ڲ���Ӧ�ð汾���������]
function QMPlugin.RunUrl(url,ID)
	local tmpact 
	if ID == 0 then		--360�����
		tmpact = "com.qihoo.browser/.BrowserActivity"
	elseif ID == 1 then	--QQ�����
		tmpact = "com.tencent.mtt.x86/.MainActivity"
	elseif ID == 2 then	--���������
		tmpact = "com.dolphin.browser.xf/mobi.mgeek.TunnyBrowser.MainActivity"
	elseif ID == 3 then	--ŷ�������
		tmpact = "com.oupeng.browser/com.opera.android.OperaMainActivity"
	elseif ID == 4 then	--���������
		tmpact = "com.mx.browser/.MxBrowserActivity"
	elseif ID == 5 then	--UC�����
		tmpact = "com.UCMobile/com.uc.browser.InnerUCMobile"
	end 
	os.execute(string.format("am start -n %s -d %s",tmpact,url))
end 

--�ж��豸���Ƿ��а�װָ��app
function QMPlugin.ExistApp(pkgname)
	local path = TempFile("applist") 
	os.execute("pm list packages  > "..path)
	local ret = readfile(path)
	s = string.find(ret,pkgname)
	if s == nil then
		return false
	else 
		return true 
	end 
end 

--�����ֻ�ʱ��
function QMPlugin.SetTime(d,t)
	os.execute("date -s "..d.."."..t)
end 

--����app
function QMPlugin.DisableApp(pkgname)
	os.execute("pm disable "..pkgname)
end 

--����app
function QMPlugin.EnableApp(pkgname)
	os.execute("pm enable  "..pkgname)
end
--[[����Ӧ��  [���ߣ�С��]
function QMPlugin.AppDisable(packagename)
	os.execute("pm disable "..packagename)
end
--���Ӧ��
function QMPlugin.AppEnable(packagename)
	os.execute("pm enable "..packagename)
end
--]]

--���������߶� 
function QMPlugin.GetNavigationBar()
	local path = TempFile("bar")
	os.execute("dumpsys window windows > "..path)
	local text = readfile(path)
	s = string.find(text,"NavigationBar")
	s = string.find(text,"mFrame",s)
	_,_,h,h1 = string.find(text,"mFrame=%[%d+,(%d+)%]%[%d+,(%d+)%]",s)
	return h1-h
end 

--��ȡ��Ļ�ֱ��� 
function QMPlugin.GetScreen()
	local path = TempFile("screen")
	os.execute("dumpsys window displays > "..path)
	local text = readfile(path)
	local ret = {}
	_,_,ret[1],ret[2],ret[3] = string.find(text,"init=(%d+)x(%d+) (%d+)dpi")
	return ret
end 

--��ȡʣ���ڴ�ٷֱ� 
function QMPlugin.GetRAM()
	local Total,Free
	local path = TempFile("RAM")
	os.execute("dumpsys meminfo > "..path)
	local text = readfile(path)
	_,_,Total = string.find(text,"Total RAM: (%d+)")
	_,_,Free = string.find(text,"Free RAM: (%d+)")
	return string.format("%d",(Free/Total)*100)
end 

--��ȡ�Ѱ�װӦ�õİ汾��  [���ߣ�С��]
function QMPlugin.AppVersion(packagename)
	local localpath = temppath().."AppVersion"
	os.execute(string.format("dumpsys package %s > %s",packagename,localpath))
	return readfile(localpath):match("versionName=(.-)\n")
end
--��ȡ�Ѱ�װӦ���״ΰ�װ��ʱ��  [���ߣ�С��]
function QMPlugin.AppFirstInstallTime(packagename)
	local localpath = temppath().."AppVersion"
	os.execute(string.format("dumpsys package %s > %s",packagename,localpath))
	return readfile(localpath):match("firstInstallTime=(.-)\n")
end
--��ȡ�Ѱ�װӦ��������װ��ʱ��  [���ߣ�С��]
function QMPlugin.AppLastUpdateTime(packagename)
	local localpath = temppath().."AppVersion"
	os.execute(string.format("dumpsys package %s > %s",packagename,localpath))
	return readfile(localpath):match("lastUpdateTime=(.-)\n")
end
--���͹㲥ǿ��ˢ��ָ��Ŀ¼�µ�ͼƬ��ͼ��չʾ  [���ߣ�С��]
function QMPlugin.UpdatePicture(picturepath)
	os.execute("am broadcast -a android.intent.action.MEDIA_MOUNTED -d file://"..picturepath)
end

--�Ƿ�����(ԭ���Ǽ�����Ƿ���)  [���ߣ�С��]
function QMPlugin.IsScreenOn()
	local localpath = temppath().."IsScreenOn"
	os.execute("dumpsys power > "..localpath)
	return readfile(localpath):match("mLightSensorEnabled=(.-) ")
end

--��������ģʽ  [���ߣ�С��]
function QMPlugin.OpenAirplane()
	os.execute("settings put global airplane_mode_on 1")
	os.execute("am broadcast -a android.intent.action.AIRPLANE_MODE --ez state true")
end
--�رշ���ģʽ  [���ߣ�С��]
function QMPlugin.CloseAirplane()
	os.execute("settings put global airplane_mode_on 0")
	os.execute("am broadcast -a android.intent.action.AIRPLANE_MODE --ez state false")
end

---------------------------------------		HTTP����	---------------------------------------

--GetHttp [���Զ���ͷ��Ϣ]
function QMPlugin.GetHttp(url, t,header)
	local path = TempFile("GET") 
	if t == null then t = 8 end 
	if header == nil then
		os.execute(string.format("curl --connect-timeout %s  -o %s '%s' ",t,path,url))
	else
		os.execute(string.format("curl --connect-timeout %s -H %s -o %s '%s'",t,header,path,url))
	end 
	result = readfile(path)
	return result
end

--GetHttp �����ļ�
function QMPlugin.GetHttpFile(url, filepath, header)
	if header == null then
		os.execute(string.format("curl -o %s '%s' ",filepath, url))
	else
		os.execute(string.format("curl -o %s -H %s '%s' ",filepath, header,url))
	end
end

--PostHttp [���Զ���ͷ��Ϣ]
function QMPlugin.PostHttp(url,post, t,header)
	local path = TempFile("POST") 
	if t == null then t = 8 end 
	if header == null then
		os.execute(string.format("curl -o %s -d '%s' --connect-timeout %s '%s'",path,post,t,url))
	else 
		os.execute(string.format("curl -o %s -d '%s' --connect-timeout %s -H % '%s'",path,post,t,header,url))
	end 
	result = readfile(path)
	return result
end 

--Post�ύ��Ϣ���ɸ���cookie��Ϣ
function QMPlugin.PostHttpC(url,post,cookie_path ,t,header)
	local path = TempFile("POST")
	if t == null then t = 8 end 
	if header == null then
		os.execute(string.format("curl -o %s -d '%s' -b '%s' --connect-timeout %s '%s'",path,post,cookie_path,t,url))
	else 
		os.execute(string.format("curl -o %s -d '%s' -b '%s' --connect-timeout %s -H % '%s'",path,post,cookie_path,t,header,url))
	end 
	result = readfile(path)
	return result
end 

--GET�ύ��Ϣ���ɸ���cookie��Ϣ
function QMPlugin.GetHttpC(url,cookie_path ,t,header)
	local path = TempFile("GET") 
	if t == null then t = 8 end 
	if header == null then
		os.execute(string.format("curl -o %s -b '%s' --connect-timeout %s '%s'",path,cookie_path,t,url))
	else 
		os.execute(string.format("curl -o %s -b '%s' --connect-timeout %s -H % '%s'",path,cookie_path,t,header,url))
	end 
	result = readfile(path)
	return result
end 

---------------------------------------	LUA����ģʽƥ��	---------------------------------------

--ȫ������ƥ��[�������Ӵ�]
function QMPlugin.RegexFind(str,pattern)
	local ret ={}
	for v in string.gmatch(str,pattern) do 
		table.insert(ret,v)
	end 
	return ret
end 

--ȫ������ƥ����Ӵ� 
function QMPlugin.RegexFindEx(str,pattern)
	local t1 = {}
	local i=1
	local ePos
	repeat
		local ta = {string.find(str, pattern, ePos)}
		ePos = ta[2]
		if ta[1] ~= nil then
			t1[i] = ta
			table.remove(t1[i],1)
			table.remove(t1[i],1)
			i=i+1
		end 
	until ta[1]==nil
	return t1
end 

---------------------------------------	��������	---------------------------------------
--�жϱ�������
function QMPlugin.type(varname)
	return type(varname)
end 

--������ɫһ��ʱ���Ƿ�仯
function QMPlugin.IsDisplayChange(x,y,x1,y1,t,delay)
	local PicPath,t1,intx,inty
	PicPath = __MQM_RUNNER_LOCAL_PATH_GLOBAL_NAME__ .."TmpPic.png"
	t1 = LuaAuxLib.GetTickCount()
	--��ȡָ����ΧͼƬ������
	LuaAuxLib.SnapShot(PicPath,x,y,x1,y1)
	--��ָ����ʱ����ѭ����ͼ
	while (LuaAuxLib.GetTickCount() - t1) < t*1000 do 
		intx = LuaAuxLib.FindPicture(x-10,y-10,x1+10,y1+10,PicPath,"101010",0,0.8)
		if intx == -1 then 
			return true 
		end 
		LuaAuxLib.Sleep(delay*1000)
	end 
	return false 
end 

--iif�ж�
function QMPlugin.iif(exp,rtrue,rfalse)
	if exp == false or exp == 0 then
		return rfalse
	else 
		return rtrue 
	end 
end 

--�߼��ȼ�����[λ����]
function QMPlugin.Eqv(t1, t2)
	if type(t1) == "boolean" and type(t2) == "boolean" then
		if t1 == t2 then
			return true
		else
			return false
		end
	else
		local i1, i2, ir
		i1 = tonumber(t1)
		i2 = tonumber(t2)
		ir = 0
		for i=0, 31 do
			local b1 = bit32.band(2^i, i1)
			local b2 = bit32.band(2^i, i2)
			if b1 == b2 then
				ir = bit32.bor(ir, 2^i)
			end
		end
		return ir
	end
end

--�߼��������
function QMPlugin.Xor(t1,t2)
	local i1, i2
	i1 = tonumber(t1)
	i2 = tonumber(t2)
	return bit32.bxor(i1, i2)
end 


--������־�ļ�·�� 
local log = {}
function QMPlugin.LogPath(path)
	log.path = path
end 
--��־��¼ 
function QMPlugin.OutLog(msg)
	local t = os.date("%H:%M:%S")
	local f = io.open(log.path,"a+")
	f:write(t.. "-\t"..msg.."\r\n")
    f:close()
end 

--����ϵͳȨ��
function QMPlugin.Mount(path)
	local localpath, text, tmppath,tmpret
	local a = function()
		localpath = TempFile("mount")
		os.execute("mount > "..localpath)
		text = readfile(localpath)
		tmppath,tmpret = string.match(text,"\n([^ ]+ "..path..")([^,]+)") 
	end 	
	a()
	os.execute("mount -o rw,remount "..tmppath)
	a()
	if string.find(tmpret,"rw") then
		return true
	else 
		return false
	end 
end 
--[[����/systemĿ¼Ϊ��д���޲Σ����ع��ص�  [���ߣ�С��]
function QMPlugin.mount()
	os.remove("/data/system.txt")
	os.execute("mount|grep system > /data/system.txt")
	f = io.open("/data/system.txt", "r") 
	xw = f:read("*all") 
	f:close()
	xw = string.sub(xw,1,string.find(xw," "))
	os.execute("su -c 'mount -o rw "..xw.." /system'")
	return xw
end
--]]

--��ȡXML�ļ� 
function QMPlugin.GetUIXml()
	os.execute("uiautomator dump ")
	local ret = readfile("/sdscard/window_dump.xml")
	return ret
end 

--��ʱ�� 
local t={} 
function QMPlugin.TimeSign(id)
	t[id] = os.time()
end 
function QMPlugin.Timer(id,diff)
	local t1 =os.time()
	if t1-t[id] >= diff then
		t[id] = os.time()
		return true
	else 
		return false
	end 
end 

--�����̨,����:������(������Ӧ��)��table����  [���ߣ�С��]
function QMPlugin.KillClean(pgknamearr)
	local localpath = temppath().."list"
	local localpath1 = temppath().."ps"
	os.execute("ls /data/app/ > "..localpath)
	os.execute("ps > "..localpath1)
	local f
	ReadContent = readfile(localpath)
	ReadContent,_ = ReadContent:gsub("-[12]%.apk","")
	f = io.open(localpath,"w")
	f:write(ReadContent)
	f:close()
	ReadContent = readfile(localpath1)
	for l in io.lines(localpath) do
		n=0
		if string.find(ReadContent,l) then
			for i, v in ipairs(pgknamearr) do
				if v == l then
					n=1
				break
				end
			end
			if n==0 then
				os.execute("am force-stop "..l)
			end
		end
	end
end

--����Ӧ�û���  [���ߣ�С��]
function QMPlugin.AppClean(packagename)
	os.execute(string.format("pm clear %s",packagename))
end

--Base64����Encoding  [���ߣ�С��]
function QMPlugin.Base64En(data)
	local key='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	return ((data:gsub('.', function(x) 
		local r,key='',x:byte()
		for i=8,1,-1 do r=r..(key%2^i-key%2^(i-1)>0 and '1' or '0') end
		return r;
	end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
		if (#x < 6) then return '' end
		local c=0
		for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
		return key:sub(c+1,c+1)
	end)..({ '', '==', '=' })[#data%3+1])
end
--Base64����Decoding  [���ߣ�С��]
function QMPlugin.Base64De(data)
	local key='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	data = string.gsub(data, '[^'..key..'=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then return '' end
		local r,f='',(key:find(x)-1)
		for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
		local c=0
		for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
		return string.char(c)
	end))
end

--��ȡ�û������Ļ����
--����Ϊ����ֱ���,����ֱ���,ɨ������
--����ֵΪһ�����飬��һ����x���꣬�ڶ�����y����  [���ߣ�С��]
function QMPlugin.Coordinate(ScreenX,ScreenY,Time)
	local localpath = temppath().."Coordinate"
	os.execute("getevent -pl>"..localpath)
	file=io.open(localpath, "r+")
	data=file:read("*l")
	while data~=nil do
		data=file:read("*l")
		if data~=nil then
			find=nil
			_,_,find=data:find("ABS_MT_POSITION_X.*max%s+(%d*)")
				if find~=nil then
					maxx=find
				end
			find=nil
			_,_,find=data:find("ABS_MT_POSITION_Y.*max%s+(%d*)")
			if find~=nil then
				maxy=find
			end
		end
	end
	times=tostring(times)
	os.execute("getevent -l -c "..Time..">"..localpath)
	file=io.open(localpath, "r+");
	data=file:read("*l")
	while data~=nil do
		data=file:read("*l")
		if data~=nil then
			if data:find("ABS_MT_POSITION_X")~=nil then
				x= math.floor(tonumber(data:sub(59,62),16)*ScreenX/maxx)
			elseif data:find("ABS_MT_POSITION_Y")~=nil then
				y= math.floor(tonumber(data:sub(59,62),16)*ScreenY/maxy)
			end
		end
	end
	os.remove(localpath)
local C = {}
C[1] = x
C[2] = y
return C
end

local function digit_to(n,s)
	assert(type(n)=="number", "arg #1 error: need a number value.")
	assert(type(s)=="string", "arg #2 error: need a string value.")
	assert((#s)>1, "arg #2 error: too short.")
	local fl = math.floor
	local i = 0
	while 1 do
		if n>(#s)^i then
			i = i + 1
		else
			break
		end
	end
	local ret = ""
	while i>=0 do
		if n>=(#s)^i then
			local tmp = fl(n/(#s)^i)
			n = n - tmp*(#s)^i
			ret = ret..s:sub(tmp+1, tmp+1)
		else
			if ret~="" then
				ret = ret..s:sub(1, 1)
			end
		end
		i = i - 1
	end
	return ret
end
local function to_digit(ns,s)
	assert(type(ns)=="string", "arg #1 error: need a string value.")
	assert(type(s)=="string", "arg #2 error: need a string value.")
	assert((#s)>1, "arg #2 error: too short.")
	local ret = 0
	for i=1,#ns do
		local fd = s:find(ns:sub(i,i))
		if not fd then
			return nil
		end
		fd = fd - 1
		ret = ret + fd*((#s)^((#ns)-i))
	end
	return ret
end
local function s2h(str,spacer)return (string.gsub(str,"(.)",function (c)return string.format("%02x%s",string.byte(c), spacer or"")end))end
local function h2s(h)return(h:gsub("(%x%x)[ ]?",function(w)return string.char(tonumber(w,16))end))end
--unicodeתutf8  [���ߣ�С��]
function QMPlugin.Unicode2Utf8(us)
	local u16p = {
		0xdc00,
		0xd800,
	}
	local u16b = 0x3ff
	local u16fx = ""
	local padl = {
		["0"] = 7,
		["1"] = 11,
		["11"] = 16,
		["111"] = 21,
	}
	local padm = {}
	for k,v in pairs(padl) do
		padm[v] = k
	end
	local map = {7,11,16,21}
	return (string.gsub(us, "\\[Uu](%x%x%x%x)", function(uc)
		local ud = tonumber(uc,16)
		for i,v in ipairs(u16p) do
			if ud>=v and ud<(v+u16b) then
				ud = ud - v + (i-1) * 0x40
				if (i-1)>0 then
					u16fx = digit_to(ud, "01")
					return ""
				end
				local bi = digit_to(ud, "01")
				uc = string.format("%x", to_digit(u16fx..string.rep("0",10-#bi)..bi,"01"))
				u16fx = ""
				ud = tonumber(uc,16)
				break
			end
		end
		local bins = digit_to(ud,"01")
		local pads = ""
		for _,i in ipairs(map) do
			if #bins<=i then
				pads = padm[i]
				break
			end
		end
		while #bins<padl[pads] do
			bins = "0"..bins
		end
		local tmp = ""
		if pads~="0" then
			tmp = bins
			bins = ""
		end
		while #tmp>0 do
			bins = "10"..string.sub(tmp, -6, -1)..bins
			tmp = string.sub(tmp, 1, -7)
		end
		return (string.gsub(string.format("%x", to_digit(pads..bins, "01")), "(%x%x)", function(w)
			return string.char(tonumber(w,16))
		end))
	end))
end
--utf8תunicode  [���ߣ�С��]
function QMPlugin.Utf82Unicode(s, upper)
	local uec = 0
	if upper then
		upper = "\\U"
	else
		upper = "\\u"
	end
	local loop1 = string.gsub(s2h(s), "(%x%x)", function(w)
		local wc = tonumber(w,16)
		if wc>0x7F then
			if uec>0 then
				uec = uec - 1
				if uec==0 then
					return w.."/"
				end
				return w
			end
			local bi = digit_to(wc, "01")
			bi = string.sub(bi, 2, -1)
			while string.sub(bi, 1, 1)=="1" do
				bi = string.sub(bi, 2, -1)
				uec = uec + 1
			end
			return "u/"..w
		else
			if uec>0 then
				uec = 0
				return w.."/"
			end
		end
		return w
	end)
	local u16p = {
		0xdc00,
		0xd800,
	}
	local u16id = 0x10000
	local loop2 = string.gsub(loop1, "u/(%x%x*)/", function(w)
		local wc = tonumber(w,16)
		local tmp
		local bi = digit_to(wc, "01")
		tmp = ""
		while #bi>8 do
			tmp = string.sub(bi, -6, -1)..tmp
			bi = string.sub(bi, 1, -9)
		end
		bi = bi..tmp
		while string.sub(bi, 1, 1)=="1" do
			bi = string.sub(bi, 2, -1)
		end
		wc = to_digit(bi, "01")
		if (wc>=u16id) then
			wc = wc - u16id
			tmp = digit_to(wc, "01")
			tmp = string.rep("0", 20-#tmp)..tmp
			local low = to_digit(string.sub(tmp, -10, -1), "01") + u16p[1]
			local high = to_digit(string.sub(tmp, 1, -11), "01") + u16p[2]
			tmp = string.format("%4x", low)
			return s2h(upper..string.format("%4x", high)..upper..string.format("%4x", low))
		end
		local h = string.format("%x", wc)
		if (#h)%2~=0 then
			h = "0"..h
		end
		return s2h(upper..h)
	end)
	return h2s(loop2)
end

--����ת����ʱ���  [���ߣ�С��]
function QMPlugin.ToTime(Date,format)
local Year,Month,Day,Hour,Min,Sec
Time = {}
_,_,Year,Month,Day,Hour,Min,Sec = Date:find(format)
Time.year=Year
Time.month=Month
Time.day=Day
Time.hour=Hour
Time.min = Min
Time.sec=Sec
return os.time(Time)
end
--����ת��Ϊ����  [���ߣ�С��]
function QMPlugin.SecToDay(Sec)
local Day,Hour,Min = 0,0,0
Sec = tonumber(Sec)
for i =1,Sec/60 do
	Min = Min + 1
	if Min == 60 then Min = 0 Hour = Hour + 1 end
	if Hour == 24 then Hour = 0 Day = Day + 1 end
end
Sec=Sec%60
return Day.."��"..Hour.."Сʱ"..Min.."��"..Sec.."��"
end
--��΢�����������ҳ  [���ߣ�С��]
function QMPlugin.WeiXinUrl(packagename,url)
	os.execute(string.format("am start -n %s/.plugin.webview.ui.tools.WebViewUI -d '%s'",packagename,url))
end
--��Ĭ�����������ҳ  [���ߣ�С��]
function QMPlugin.OpenWeb(url)
	if url:find("http://") == nil then url = "http://"..url end
	os.execute(string.format("am start -a android.intent.action.VIEW -d "..url))
end

--���㾭γ��֮���ֱ�߾���  [���ߣ�С��]
function QMPlugin.GetDistance(lat1,lng1,lat2,lng2)
	local rad = function(d) return d*math.pi/180 end
	local radLat1 = rad(lat1)
	local radLat2 = rad(lat2)
	return math.floor(2*math.asin(math.sqrt(math.pow(math.sin((radLat1-radLat2)/2),2)+math.cos(radLat1)*math.cos(radLat2)*math.pow(math.sin((rad(lng1) - rad(lng2))/2),2)))*6378.137*10000)/10000
--������һ��������׼��������,�˴�����뾶����ѡ�����6378.137km
end

--�Ա��Ƿ���,����������ʱ����ꡢ�¡��ա�ʱ���֡���,����ֵ�����ڷ���-1,��ȡ����ʱ��ʧ�ܷ���null,δ���ڷ��ؾ��뵽��ʣ���ʱ��(��λ��)  [���ߣ�С��]
function QMPlugin.CompareTime(Year,Month,Day,Hour,Min,Sec)
	local NowNetTime = LuaAuxLib.URL_Operation("http://52xiaov.com/getipinfo.php"):match("����%):(.-)</body>")
	if NowNetTime == nil then return null else NowNetTime = tonumber(NowNetTime) end
	local Time = {};Time.year=Year;Time.month=Month;Time.day=Day;Time.hour=Hour;Time.min = Min;Time.sec=Sec
	local ExpireTime = os.time(Time)
	if NowNetTime > ExpireTime then return -1 else return (ExpireTime - NowNetTime) end
end

--���㼸��������  [���ߣ�С��]
function QMPlugin.LateTime(late,Year,Month,Day)
	if Day ~= nil then
		local Time = {};Time.year=Year;Time.month=Month;Time.day=Day
		local starttime = os.time(Time)
	else
		local starttime = os.time()
	end
	return os.date("%Y-%m-%d",starttime + tonumber(late) * 24 * 60 * 60)
end

--��ȡͨ��״̬������ֵΪ0����ʾ����״̬��1��ʾ����δ����״̬��2��ʾ�绰ռ��״̬  [���ߣ�С��]
function QMPlugin.CallState()
	local localpath = temppath().."CallState"
	os.execute("dumpsys telephony.registry > "..localpath)
	return readfile(localpath):match("mCallState=(.-)\n")
end
--��ȡ�������  [���ߣ�С��]
function QMPlugin.CallIncomingNumber()
	local localpath = temppath().."CallIncomingNumber"
	os.execute("dumpsys telephony.registry > "..localpath)
	return readfile(localpath):match("mCallIncomingNumber=(.-)\n")
end
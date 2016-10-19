<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<%=request.getContextPath()%>/xhEditor/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/xhEditor/xheditor-1.2.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/xhEditor/zh-cn.js"></script>
<title>Insert title here</title>
<script>
	$(function(){
		/* $("#content").xheditor({tools:'full'});
		$("#content").xheditor({tools:'mfull'}); */
		$("#content").xheditor({
			tools:'simple',
			skin:'o2007silver',
			})
		}
	})

</script>
</head>
<body>
<textarea rows="20" cols="50"  id="content">

</textarea>
<textarea id="elm1" name="elm1" class="xheditor" rows="12" cols="80" >
	</textarea>
</body>
</html>
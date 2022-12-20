<h1>NOT-SO-SAFEWAY</h1>
<%
if (session.getAttribute("authenticatedUser") != null){
    String user = session.getAttribute("authenticatedUser").toString();
    out.print("<h5>"+"Hello, " + user.substring(0, 1).toUpperCase() + user.substring(1) + "! We're glad you're back!</h5>");
}
%>
<table class="table1">
    <tr>
        <th><a href="index.jsp" class="button3">Home</a></th>
        <th><a href="listprod.jsp" class="button3">Shop</a></th>
        <th><a href="listorder.jsp" class="button3">Orders</a></th>
        <th><a href="customer.jsp" class="button3">Customer Info</a></th>
        <th><a href="showcart.jsp" class="button3">My Shopping Cart</a></th>
    </tr>
</table>

<div id="google_translate_element"></div>
<script type="text/javascript">
    function googleTranslateElementInit() {
        new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
    }
</script>
<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>

<hr>
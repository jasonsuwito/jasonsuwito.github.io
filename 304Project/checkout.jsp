<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en" style="text-align: left;">
<head>
    <title>Checkout</title>
    <link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<h1>Enter your Customer ID and Password to complete the transaction:</h1>
<a href="showcart.jsp" class="button3">← Back to Cart</a>
<br><br>

<form method="get" action="order.jsp">
    <table style="border-spacing: 0 5px;text-align: right;">
        <th>Customer Information:</th>
            <tr>
                <td>Customer ID:</td>
                <td><input type="text" name="customerId" size="50" required></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="text" name="customerPassword" size="50" required></td>
            </tr>
        <th>Shipping Information:</th>
            <tr>
                <td>Receipient Name:</td>
                <td><input type="text" name="shippingName" size=50 maxlength=50 required></td>
            </tr>
            <tr>
                <td>Address:</td>
                <td><input type="text" name="shippingAddress" size=50 maxlength="50" required></td>
            </tr>
            <tr>
                <td>Postal Code:</td>
                <td><input type="text" name="shippingPostal" size=50 maxlength="50" required></td>
            </tr>
            <tr>
                <td>Country:</td>
                <td><input type="text" name="shippingCountry" size=50 maxlength="50" required></td>
            </tr>
        <th>Payment Information:</th>
            <tr>
                <td>Payment Option:</td>
                <td style="text-align:left"><select size="1" name="paymentOption">
                    <option>Visa</option>
                    <option>MasterCard</option>
                    <option>American Express</option>   
                </select></td>
            </tr>
            <tr>
                <td>Card Number:</td>
                <td><input type="text" name="paymentCardNo" size=50 maxlength=50 required></td>
            </tr>
            <tr>
                <td>Name on Card:</td>
                <td><input type="text" name="paymentCardName" size=50 maxlength="50" required></td>
            </tr>
            <tr>
                <td>Expiry Date:</td>
                <td style="text-align:left"><input type="text" name="paymentCardExp" size=5 maxlength="5" required></td>
            </tr>
            <tr>
                <td>CVV:</td>
                <td style="text-align:left"><input type="text" name="paymentCardCVV" size=3 maxlength="3" required></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" value="Submit"><input type="reset" value="Reset"></td>
            </tr>
    </table>
</form>
</html>
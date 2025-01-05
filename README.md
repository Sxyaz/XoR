# Game Guardian XoR Guide.


<h2> What is XOR Encryption? </h2>
XOR(Exclusive OR) is an encryption type. It uses at Cryoptology, Bit Opeations and some Exploit Detection. But how it works?
<table>
  <thead>
    <tr>
      <th>Value 1</th>
      <th>Value 2</th>
      <th>XOR Result</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <td>0</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <td>1</td>
      <td>0</td>
      <td>1</td>
    </tr>
    <tr>
      <td>1</td>
      <td>1</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
Simply, it uses 1 value as key, 1 value as your value. And gives an encrypted value.
You can simply use XOR with integer values.

<h2> XOR in Game Guardian </h2>
A lot of games are using XOR to protect their values.
What happens if you edit a value without xoring? Crash.

<h2> Integer XORs in GG </h2>
Integer values can easily be edited. Usually their Key and Encrypted value matchs.
<table>
  <thead>
    <tr>
      <th>Key</th>
      <th>Raw Value</th>
      <th>XOR Result</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>444444</td>
      <td>5</td>
      <td>444441</td>
    </tr>
    <tr>
      <td>111</td>
      <td>9</td>
      <td>102</td>
    </tr>
    <tr>
      <td>999</td>
      <td>210</td>
      <td>821</td>
    </tr>
  </tbody>
</table>

<h2> Decimal XORs in GG </h2>
Usually their Key and Encrypted value dont match.
<h3> OK. But why they dont match? </h3>
<li>They are not stable as Integers.</li>
<li>Rounding erros. Like 0.1 cannot be represented as a complete float.</li>
<li>Normally it doesnt support XOR.</li>

<h3> How do we XOR floats? </h3>
In GG if you swap middle bytes after xoring your value, xor key and encrypted value will match.
<h2></h2>
<li>Before swap</li>
<table>
  <thead>
    <tr>
      <th>Key</th>
      <th>Encrypted Value</th>
      <th>XOR Result (Raw Value)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>2145515807 (NaNF)</td>
      <td>1096841349 (14.02942371368)</td>
      <td>1048674714 (0.25294190645)</td>
    </tr>
</table>
Here, if you XOR Key and Encrypted Value it will give 1048674714 (0.25294190645). But in the game memory this raw value is 1050253722 (0.30000001192).
<h2></h2>
<li>Swapping bytes</li>
You have to swap middle bytes of Key dword value. Like:
<h3>2145515807 Dword</h3>
<table>
  <thead>
    <tr>
      <th>First Byte</th>
      <th>Second Byte</th>
      <th>Third Byte</th>
      <th>Fourth Byte</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>31</td>
      <td>-7</td>
      <td>-31</td>
      <td>127</td>
    </tr>
  </tbody>
</table>
You need to swap 2nd and 3rd bytes.
<table>
  <thead>
    <tr>
      <th>First Byte</th>
      <th>Second Byte</th>
      <th>Third Byte</th>
      <th>Fourth Byte</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>31</td>
      <td>-31</td>
      <td>-7</td>
      <td>127</td>
    </tr>
  </tbody>
</table>
Now XOR result should give the correct result.
<table>
  <thead>
    <tr>
      <th>Key</th>
      <th>Encrypted Value</th>
      <th>XOR Result (Raw Value)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>2147082527 (NaNF)</td>
      <td>1096841349 (14.02942371368)</td>
      <td>1050253722 (0.30000001192)</td>
    </tr>
</table>
Now we have the correct XOR Key and Value.
<h2></h2>
<h1>Thanks For Reading!</h1>

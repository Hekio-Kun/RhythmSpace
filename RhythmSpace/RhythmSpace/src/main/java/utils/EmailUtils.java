package utils;

import java.util.Properties;
import java.util.Random;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtils {

    // Điền Email và Mật khẩu ứng dụng (16 ký tự) của bạn vào đây
    private static final String EMAIL_FROm = "rhythmspace.system@gmail.com";
    private static final String APP_PASSWORD = "kngz pdjt ovjr bmfp"; 

    // Hàm tạo mã OTP ngẫu nhiên 6 chữ số
    public static String generateOTP() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    // Hàm gửi email
    public static boolean sendEmail(String toEmail, String otpCode) {
        boolean test = false;

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_FROm, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_FROm));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("RhythmSpace - Ma xac minh dang ky tai khoan");
            
            // Nội dung Email có thể dùng thẻ HTML cho đẹp
            String htmlContent = "<h3>Chào mừng bạn đến với RhythmSpace!</h3>"
                    + "<p>Mã xác minh (OTP) của bạn là: <b style='color:blue; font-size:20px;'>" + otpCode + "</b></p>"
                    + "<p>Vui lòng không chia sẻ mã này với bất kỳ ai.</p>";
            
            message.setContent(htmlContent, "text/html; charset=utf-8");

            Transport.send(message);
            test = true;
        } catch (Exception e) {
            System.out.println("Lỗi khi gửi email: " + e.getMessage());
        }
        return test;
    }
    
    // Test thử xem gửi được chưa
    public static void main(String[] args) {
        String myOTP = generateOTP();
        // Thay bằng email cá nhân của bạn để test
        boolean isSent = sendEmail("rhythmspace.system@gmail.com", myOTP); 
        if(isSent) {
            System.out.println("Gửi OTP thành công! Mã là: " + myOTP);
        } else {
            System.out.println("Gửi thất bại!");
        }
    }
}
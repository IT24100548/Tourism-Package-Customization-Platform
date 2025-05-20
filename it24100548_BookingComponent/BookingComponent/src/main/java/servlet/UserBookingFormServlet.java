package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/UserBookingFormServlet")
public class UserBookingFormServlet extends HttpServlet {
    private static final String PACKAGE_FILE =
            "C:\\Users\\ASUS\\OneDrive\\Desktop\\Tourism-Package-Customization-Platform\\it24100548_BookingComponent\\BookingComponent\\src\\main\\resources\\packages.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<String[]> packageList = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(PACKAGE_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", 5);
                if (parts.length >= 4) {
                    packageList.add(new String[]{ parts[1], parts[3] });  // name, price
                }
            }
        }

        // Build HTML <option> elements
        StringBuilder options = new StringBuilder();
        for (String[] pkg : packageList) {
            options.append("<option value=\"")
                    .append(pkg[0])
                    .append("\">")
                    .append(pkg[0])
                    .append(" - ")
                    .append(pkg[1])
                    .append("</option>");
        }

        request.setAttribute("packageOptions", options.toString());
        request.getRequestDispatcher("/jsp/userbookingform.jsp").forward(request, response);
    }
}

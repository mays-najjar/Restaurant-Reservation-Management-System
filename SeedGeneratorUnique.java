import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

public class SeedGeneratorUnique {
    static Random rand = new Random();

    static String randomString(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++)
            sb.append(chars.charAt(rand.nextInt(chars.length())));
        return sb.toString();
    }

    static String[] randomName() {
        String[] firstNames = { "John", "Jane", "Alice", "Bob", "Charlie", "Diana", "Eve", "Frank", "Grace", "Henry" };
        String[] lastNames = { "Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis",
                "Rodriguez", "Martinez" };
        return new String[] { firstNames[rand.nextInt(firstNames.length)], lastNames[rand.nextInt(lastNames.length)] };
    }

    static String randomEmail(String first, String last, Set<String> usedEmails) {
        String email;
        String[] domains = { "gmail.com", "yahoo.com", "hotmail.com", "outlook.com", "example.com" };
        int attempts = 0;
        do {
            email = first.toLowerCase() + "." + last.toLowerCase() + attempts + "@"
                    + domains[rand.nextInt(domains.length)];
            attempts++;
            if (attempts > 1000) {
                System.err.println(
                        "Error: Could not generate unique email after 1000 attempts for " + first + " " + last);
                email = first.toLowerCase() + "." + last.toLowerCase() + attempts + "@"
                        + domains[rand.nextInt(domains.length)];
                break;
            }
        } while (usedEmails.contains(email));
        usedEmails.add(email);
        return email;
    }

    static String randomPhone() {
        return String.format("(%03d) %03d-%04d", rand.nextInt(900) + 100, rand.nextInt(900) + 100, rand.nextInt(10000));
    }

    static String randomAddress() {
        String[] streets = { "Main St", "Oak Ave", "Pine Rd", "Elm Blvd", "Maple Ln" };
        return (rand.nextInt(999) + 1) + " " + streets[rand.nextInt(streets.length)] + ", City "
                + (rand.nextInt(50) + 1);
    }

    public static void main(String[] args) {
        try {
            // Master Seed Data File
            FileWriter masterFile = new FileWriter("MasterSeedData.sql");
            masterFile.write("USE RestaurantReservationDB;\nGO\n\n");

            // Restaurants
            masterFile.write("-- Insert Restaurants\n");
            for (int i = 1; i <= 50; i++) {
                String name = "Restaurant " + i;
                String address = randomAddress().replace("'", "''");
                String phone = randomPhone();
                String hours = "9 AM - 10 PM";
                masterFile.write(String.format(
                        "INSERT INTO Restaurants (Name, Address, PhoneNumber, OpeningHours) VALUES ('%s','%s','%s','%s');\n",
                        name.replace("'", "''"), address, phone, hours));
            }
            masterFile.write("GO\n\n");

            // Customers
            masterFile.write("-- Insert Customers\n");
            Set<String> usedEmails = new HashSet<>();
            try {
                for (int i = 1; i <= 400; i++) {
                    String[] name = randomName();
                    String email = randomEmail(name[0], name[1], usedEmails);
                    String phone = randomPhone();
                    masterFile.write(String.format(
                            "INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber) VALUES ('%s','%s','%s','%s');\n",
                            name[0].replace("'", "''"), name[1].replace("'", "''"), email.replace("'", "''"),
                            phone.replace("'", "''")));
                    if (i % 10 == 0) {
                        System.out.println("Generated " + i + " customers");
                    }
                }
                masterFile.write("GO\n\n");
            } catch (IOException e) {
                System.err.println("Error writing to MasterSeedData.sql: " + e.getMessage());
                e.printStackTrace();
            }

            // Tables
            masterFile.write("-- Insert Tables\n");
            Set<String> usedTables = new HashSet<>();
            for (int r = 1; r <= 50; r++) {
                for (int t = 1; t <= 2; t++) {
                    int capacity = rand.nextInt(7) + 2;
                    while (usedTables.contains(r + "-" + t))
                        t++;
                    usedTables.add(r + "-" + t);
                    masterFile.write(String.format(
                            "INSERT INTO Tables (RestaurantId, Capacity) VALUES (%d,%d);\n", r, capacity));
                }
            }
            masterFile.write("GO\n\n");

            // Employees
            masterFile.write("-- Insert Employees\n");
            String[] positions = { "Manager", "VIPOrdersWaiter", "StandardWaiter", "AssistantWaiter" };
            for (int r = 1; r <= 50; r++) {
                for (int e = 1; e <= 2; e++) {
                    String[] name = randomName();
                    String pos = positions[rand.nextInt(positions.length)];
                    masterFile.write(String.format(
                            "INSERT INTO Employees (RestaurantId, FirstName, LastName, Position) VALUES (%d,'%s','%s','%s');\n",
                            r, name[0].replace("'", "''"), name[1].replace("'", "''"), pos));
                }
            }
            masterFile.write("GO\n\n");

            // MenuItems
            masterFile.write("-- Insert MenuItems\n");
            for (int r = 1; r <= 50; r++) {
                for (int m = 1; m <= 20; m++) {
                    String name = "Item " + m + " at Restaurant " + r;
                    String desc = randomString(20).replace("'", "''");
                    double price = Math.round((rand.nextDouble() * 45 + 5) * 100.0) / 100.0;
                    masterFile.write(String.format(
                            "INSERT INTO MenuItems (RestaurantId, Name, Description, Price) VALUES (%d,'%s','%s',%.2f);\n",
                            r, name.replace("'", "''"), desc, price));
                }
            }
            masterFile.write("GO\n\n");

            // Reservations
            masterFile.write("-- Insert Reservations\n");
            Map<Integer, List<Integer>> tablesPerRestaurant = new HashMap<>();
            int tableIdCounter = 1;
            for (int r = 1; r <= 50; r++) {
                List<Integer> tableIds = new ArrayList<>();
                tableIds.add(tableIdCounter++);
                tableIds.add(tableIdCounter++);
                tablesPerRestaurant.put(r, tableIds);
            }

            for (int res = 1; res <= 500; res++) {
                int cust_id = rand.nextInt(400) + 1;

                int rest_id = rand.nextInt(50) + 1;

                List<Integer> availableTables = tablesPerRestaurant.get(rest_id);
                int table_id = availableTables.get(rand.nextInt(availableTables.size()));

                int day = rand.nextInt(28) + 1;
                int month = rand.nextInt(12) + 1;
                int hour = rand.nextInt(11) + 10; 
                String date = String.format("2023-%02d-%02d %02d:00:00", month, day, hour);

                int party = rand.nextInt(8) + 1;

                masterFile.write(String.format(
                        "INSERT INTO Reservations (CustomerId, RestaurantId, TableId, ReservationDate, PartySize) VALUES (%d,%d,%d,'%s',%d);\n",
                        cust_id, rest_id, table_id, date, party));
            }
            masterFile.write("GO\n\n");
            // Orders
            masterFile.write("-- Insert Orders\n");
            for (int o = 1; o <= 500; o++) {
                int res_id = rand.nextInt(500) + 1;
                int emp_id = rand.nextInt(100) + 1;
                int day = rand.nextInt(28) + 1;
                int month = rand.nextInt(12) + 1;
                int hour = rand.nextInt(11) + 10;
                String date = String.format("2023-%02d-%02d %02d:00:00", month, day, hour);
                double total = Math.round((rand.nextDouble() * 180 + 20) * 100.0) / 100.0;
                masterFile.write(String.format(
                        "INSERT INTO Orders (ReservationId, EmployeeId, OrderDate, TotalAmount) VALUES (%d,%d,'%s',%.2f);\n",
                        res_id, emp_id, date, total));
            }
            masterFile.write("GO\n\n");

            // OrderItems
            masterFile.write("-- Insert OrderItems\n");
            Set<String> usedOrderItems = new HashSet<>();
            for (int oi = 1; oi <= 1500; oi++) {
                int order_id = rand.nextInt(500) + 1;
                int item_id = rand.nextInt(1000) + 1;
                while (usedOrderItems.contains(order_id + "-" + item_id))
                    item_id = rand.nextInt(1000) + 1;
                usedOrderItems.add(order_id + "-" + item_id);
                int qty = rand.nextInt(5) + 1;
                masterFile.write(String.format(
                        "INSERT INTO OrderItems (OrderId, ItemId, Quantity) VALUES (%d,%d,%d);\n",
                        order_id, item_id, qty));
            }
            masterFile.write("GO\n\n");

            masterFile.close();

            System.out.println("Master seed data generated in MasterSeedData.sql");

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

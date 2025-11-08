import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_now/view/authentication/utils/auth_utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    const Color primaryColor = AppColors.primary;
    const Color secondaryColor = AppColors.secondary;

    return Scaffold(
      backgroundColor: Colors.white,
      

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20),
              CustomText(
              text: "Hey Micdev 👋",
             
                fontSize: 24,
                fontWeight: FontWeight.w700,
                
              
            ),
            const SizedBox(height: 6),
            CustomText(
              text: "Ready to capture your ideas? ",
              
                fontSize: 15,
                color: Colors.grey[600],
                
              
            ),
                
                // // 👇 Quick Actions
                // Text(
                //   "Quick Actions",
                //   style: GoogleFonts.poppins(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w600,
                //     color: Colors.black87,
                //   ),
                // ),
                // const SizedBox(height: 12),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     _buildQuickAction(Icons.mic, "Record", secondaryColor),
                //     _buildQuickAction(Icons.note_add, "New Note", primaryColor),
                //     _buildQuickAction(Icons.import_contacts, "Import", Colors.amber.shade600),
                //   ],
                // ),
                const SizedBox(height: 20),
                //  👇 Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search notes...",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
        
                // const SizedBox(height: 30),
                
                const SizedBox(height: 20),
        
                // 👇 Summary Cards
                Text(
                  "Overview",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  spacing: 30,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSummaryCard("Notes", "12", primaryColor),
                    _buildSummaryCard("AI Summaries", "5", secondaryColor),
                  ],
                ),
        
                const SizedBox(height: 30),
        
                Divider(),
                
        
                // 👇 Recent Notes Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Notes",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    Assets.images.noNotes.path,
                    height: 300,
                  ),
                )
        
                // 👇 Notes List (mock)
                // _buildNoteTile(
                //   title: "Voice transcription summary",
                //   snippet: "AI summarized your last meeting notes...",
                //   color: primaryColor.withOpacity(0.1),
                // ),
                // _buildNoteTile(
                //   title: "Daily reflection",
                //   snippet: "Talked about consistency and productivity...",
                //   color: secondaryColor.withOpacity(0.1),
                // ),
                // _buildNoteTile(
                //   title: "Book ideas",
                //   snippet: "AI extracted 3 main points from your brainstorm.",
                //   color: Colors.amber.withOpacity(0.1),
                // ),
              ],
            ),
          ),
        ),
      ),

      // 👇 Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor.withOpacity(0.6),
        onPressed: () {
          context.go('/note_taking');
        },
        elevation: 0,
        child: Icon(
          Icons.add,
        ),
        
        
      ),
    );
  }

  // 🔹 Quick Action Card
  Widget _buildQuickAction(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 6),
        Text(label, style: GoogleFonts.poppins(fontSize: 13)),
      ],
    );
  }

  // 🔹 Summary Card
  Widget _buildSummaryCard(String label, String count, Color color) {
    return Container(
      height: 90,
      width: 160,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count,
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Note Tile
  Widget _buildNoteTile({required String title, required String snippet, required Color color}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.description_outlined, color: Colors.black54),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  snippet,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Quiz {
  final String section;
  final String title;
  final List<Map<String, dynamic>> questions;

  Quiz({required this.section, required this.title, required this.questions});
}

List<Quiz> quiz = [
  Quiz(
    section: "SECTION 1: GENERAL KNOWLEDGE",
    title: "What is the official name of Sky City in Changsha?",
    questions: [
      {
        "question": "What is the official name of Sky City in Changsha?",
        "options": ["Sky Tower", "J220", "Sky City One", "Changsha Mega Tower"],
        "answer": "Sky City One"
      },
      {
        "question":
            "Who was the main company behind the construction of Sky City?",
        "options": [
          "Broad Sustainable Building",
          "China State Construction Engineering",
          "Shanghai Tower Group",
          "Skidmore, Owings & Merrill"
        ],
        "answer": "Broad Sustainable Building"
      },
      {
        "question": "What was the proposed height of Sky City?",
        "options": ["500 meters", "828 meters", "838 meters", "1000 meters"],
        "answer": "838 meters"
      },
      {
        "question": "In what year was the construction of Sky City halted?",
        "options": ["2011", "2013", "2015", "2017"],
        "answer": "2013"
      },
      {
        "question": "What made Sky City unique in terms of construction speed?",
        "options": [
          "It was planned to be built in only 90 days",
          "It used entirely glass materials",
          "It was going to be built underwater",
          "It was the first Chinese skyscraper to use AI technology"
        ],
        "answer": "It was planned to be built in only 90 days"
      },
    ],
  ),
  Quiz(
    section: "SECTION 2: Design & Features",
    title: "Design & Features of Sky City",
    questions: [
      {
        "question":
            "What type of construction method was planned for Sky City?",
        "options": [
          "Traditional concrete and steel framework",
          "Prefabricated modular construction",
          "3D-printed structure",
          "Wooden-based eco-structure"
        ],
        "answer": "Prefabricated modular construction"
      },
      {
        "question": "How many floors was Sky City expected to have?",
        "options": ["100", "202", "220", "300"],
        "answer": "220"
      },
      {
        "question": "What kind of facilities were planned inside Sky City?",
        "options": [
          "Schools",
          "Hospitals",
          "Shopping centers",
          "Underground parking"
        ],
        "answer": "Schools"
      },
      {
        "question":
            "If completed, Sky City would have surpassed which building as the world’s tallest?",
        "options": [
          "Burj Khalifa",
          "Shanghai Tower",
          "Petronas Towers",
          "Taipei 101"
        ],
        "answer": "Burj Khalifa"
      },
      {
        "question":
            "What was the main reason the construction of Sky City was stopped?",
        "options": [
          "Lack of investor interest",
          "Environmental concerns and government approval issues",
          "Design flaws",
          "Political instability"
        ],
        "answer": "Environmental concerns and government approval issues"
      },
    ],
  ),
  Quiz(
    section: "SECTION 3: Impact & Legacy",
    title: "Impact & Legacy of Sky City",
    questions: [
      {
        "question":
            "Sky City was expected to be built in which Chinese province?",
        "options": ["Guangdong", "Hunan", "Beijing", "Sichuan"],
        "answer": "Hunan"
      },
      {
        "question": "What was the estimated cost of constructing Sky City?",
        "options": ["500 million", "850 million", "1.2 billion", "3 billion"],
        "answer": "850 million"
      },
      {
        "question":
            "If completed, Sky City would have accommodated how many people?",
        "options": ["10,000", "30,000", "50,000", "100,000"],
        "answer": "50,000"
      },
      {
        "question":
            "What energy-efficient feature was included in Sky City's design?",
        "options": [
          "Wind turbines on every floor",
          "A self-sustaining agricultural system",
          "Solar panels and green roofs",
          "A completely glass exterior for maximum sunlight"
        ],
        "answer": "Solar panels and green roofs"
      },
      {
        "question": "What remains of the Sky City project today?",
        "options": [
          "A completed base foundation with no further construction",
          "A fully operational skyscraper",
          "A redesigned, smaller tower in its place",
          "A museum showcasing its design"
        ],
        "answer": "A completed base foundation with no further construction"
      },
    ],
  ),
];

class Shopping {
  final String image;
  final String title;
  final int price;

  Shopping({required this.image, required this.title, required this.price});
}

List<Shopping> shoppingItems = [
  Shopping(image: "images/sofa.jpg", title: "Minimalistic sofa", price: 2000),
  Shopping(
      image: "images/table.jpg", title: "Floating glass table", price: 1500),
  Shopping(
      image: "images/cleaning robot .jpeg",
      title: "Cleaning robot",
      price: 350),
  Shopping(image: "images/lightinng.jpg", title: "Smart lighting", price: 250),
  Shopping(image: "images/beds.webp", title: "Smart beds", price: 4000),
  Shopping(
      image: "images/display.webp", title: "Holographic display", price: 5000),
  Shopping(image: "images/platns.webp", title: "Plants", price: 30),
  Shopping(
      image: "images/apartments-exclusive.jpg",
      title: "Exclusive apartment",
      price: 2500000),
];

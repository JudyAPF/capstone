class EducationalModule {
  final String title;
  final String category;
  final String pdfPath;
  final String author;
  final DateTime date;
  final String description; // Added description field

  EducationalModule({
    required this.title,
    required this.category,
    required this.pdfPath,
    required this.author,
    required this.date,
    required this.description, // Initialize description
  });
}


final List<EducationalModule> modules = [
  EducationalModule(
    title: 'Budgeting 101: What Everyone Needs To Know',
    category: 'Budgeting',
    pdfPath: 'assets/modules/Budgeting1.pdf',
    author: 'Kovar Wealth Management',
    date: DateTime(2024),
    description: 'This guide is your essential toolkit for mastering the basics of budgeting. Lets dive in and unlock the secrets to effective budgeting for a more secure financial future!',
  ),
  EducationalModule(
    title: 'Understanding Budgets and the Budgeting Process',
    category: 'Budgeting',
    pdfPath: 'assets/modules/Budgeting2.pdf',
    author: 'RL Smathers',
    date: DateTime(2023, 2, 27),
    description: 'The usefulness of a budget depends on the reliability of the information used to create the budget. Unrealistic estimates of prices, yields, or input quantities would lessen the accuracy of the budget and could possibly lead to a faulty decision. Sound management decisions can be made using budgets, but care must be exercised in using only reliable information',
  ),
  EducationalModule(
    title: 'Better Business Budget Planning',
    category: 'Budgeting',
    pdfPath: 'assets/modules/Budgeting3.pdf',
    author: 'Dawkins Brown',
    date: DateTime(0), 
    description: 'With your budget in place, let the tracking begin. After determining where your money is going, it will be easier to make decisions and gain control of your spending. Cutting back is usually a better place to start than completely removing an expense. After trimming extra spending, it helps to have a goal to save for each month. Setting a goal needs to be SMART',
  ),
  EducationalModule(
    title: 'Basic Organizational Budgeting',
    category: 'Budgeting',
    pdfPath: 'assets/modules/Budgeting4.pdf',
    author: 'Santa Ana College',
    date: DateTime(2010, 0, 0),
    description: 'All businesses start out with three main elements prominently featured in the general make up of the endeavor. These would be listed as revenue to be earned, expenses to be incurred along the way and the projected profits expected. These three categories are usually studied in depth before the actual business entity is launched and through this process there is always the need to have an effective budgeting platform in place. Get all the info you need here',
  ),
  EducationalModule(
    title: 'Budget and financial planning',
    category: 'Budgeting',
    pdfPath: 'assets/modules/Budgeting5.pdf',
    author: 'European Commission',
    date: DateTime(2015, 0, 0),
    description: 'One of the tasks you may face as a financial officer of a club or an organization is that of preparing a budget. This is especially true if your organization holds many events and fundraisers, and transacts a lot of business. There are all types of methods for preparing budgets, from flipping coins to using computer spreadsheets. No one method is best for all organizations. The method described below is fairly simple.',
  ),
  //Brand Management
  EducationalModule(
    title: 'Strategic Brand Management',
    category: 'Brand Management',
    pdfPath: 'assets/modules/Brand1.pdf',
    author: 'Kevin Lane Keller and Vanitha Swaminathan',
    date: DateTime(2018, 12, 29),
    description: 'This book deals with brands—why they are important, what they represent to consumers, and what firms should do to manage them properly. As many business executives now recognize, perhaps one of the most valuable assets a firm has are the brands it has invested in and developed over time. Although brands may represent invaluable intangible assets, creating and nurturing a strong brand poses considerable challenges',
  ),
];
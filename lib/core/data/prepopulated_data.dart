// ============================================================================
// WAEC SUBJECTS DATA - COMPLETE DATASET
// This file contains all 36 WAEC subjects with their syllabuses
// ============================================================================

import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/exampaper.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/subject.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/syllabus.dart';
import 'package:ahiaa_web/features/practice_exam/data/models/topic.dart';
import 'package:ahiaa_web/injection_container.dart';
import 'package:injectable/injectable.dart';


class WaecSubjectsData {
  static List<Subject> getAllSubjects() {
    return [
      // ========================================================================
      // COMPULSORY SUBJECTS
      // ========================================================================
      
      _englishLanguage(),
      _generalMathematics(),
      _civicEducation(),
      
      // ========================================================================
      // SCIENCE SUBJECTS
      // ========================================================================
      
      _physics(),
      _chemistry(),
      _biology(),
      _furtherMathematics(),
      _agriculturalScience(),
      _healthEducation(),
      _physicalEducation(),
      
      // ========================================================================
      // ARTS/HUMANITIES SUBJECTS
      // ========================================================================
      
      _literatureInEnglish(),
      _government(),
      _history(),
      _christianReligiousStudies(),
      _islamicStudies(),
      _music(),
      _visualArt(),
      
      // ========================================================================
      // LANGUAGES
      // ========================================================================
      
      _arabic(),
      _french(),
      _hausa(),
      _igbo(),
      _yoruba(),
      
      // ========================================================================
      // COMMERCIAL/BUSINESS/SOCIAL SCIENCE
      // ========================================================================
      
      _economics(),
      _commerce(),
      _financialAccounting(),
      _geography(),
      
      // ========================================================================
      // TECHNICAL/VOCATIONAL
      // ========================================================================
      
      _technicalDrawing(),
      _basicElectricity(),
      _basicElectronics(),
      _autoMechanics(),
      _buildingConstruction(),
      _metalWork(),
      _woodWork(),
      
      // ========================================================================
      // HOME ECONOMICS/VOCATIONAL
      // ========================================================================
      
      _foodsAndNutrition(),
      _clothingAndTextiles(),
      _homeManagement(),
    ];
  }

  // ==========================================================================
  // COMPULSORY SUBJECTS
  // ==========================================================================

  static Subject _englishLanguage() {
    return Subject(
      id: 'eng_001',
      name: 'English Language',
      code: '302',
      category: SubjectCategory.compulsory,
      isCompulsory: true,
      description: 'Test of proficiency in written and spoken English',
      syllabuses: [
        Syllabus(
          id: 'eng_waec_2025',
          subjectId: 'eng_001',
          examBody: ExamBody.waec,
          year: 2025,
          aims: [
            'Develop proficiency in English communication',
            'Test receptive and productive abilities in English',
            'Evaluate written and spoken English skills',
          ],
          papers: [
            ExamPaper(
              id: 'eng_paper1',
              name: 'Paper 1',
              type: PaperType.essay,
              duration: '2½ hours',
              totalMarks: 120,
              description: 'Essay Writing, Comprehension and Summary',
            ),
            ExamPaper(
              id: 'eng_paper2',
              name: 'Paper 2',
              type: PaperType.multipleChoice,
              duration: '1 hour',
              totalMarks: 50,
              numberOfQuestions: 50,
              description: 'Lexis and Structure',
            ),
            ExamPaper(
              id: 'eng_paper3',
              name: 'Paper 3',
              type: PaperType.oral,
              duration: '45 minutes',
              totalMarks: 30,
              description: 'Test of Orals',
            ),
          ],
          topics: [
            Topic(
              id: 'eng_topic_001',
              name: 'Essay Writing',
              subtopics: [
                'Narrative Essay',
                'Descriptive Essay',
                'Argumentative Essay',
                'Expository Essay',
              ],
              estimatedQuestions: 1,
            ),
            Topic(
              id: 'eng_topic_002',
              name: 'Letter Writing',
              subtopics: [
                'Formal Letter',
                'Informal Letter',
                'Letter of Application',
                'Business Letters',
              ],
              estimatedQuestions: 1,
            ),
            Topic(
              id: 'eng_topic_003',
              name: 'Comprehension and Summary',
              subtopics: [
                'Reading Comprehension',
                'Summary Writing',
                'Inference and Deduction',
              ],
              estimatedQuestions: 2,
            ),
            Topic(
              id: 'eng_topic_004',
              name: 'Lexis and Structure',
              subtopics: [
                'Vocabulary',
                'Idioms and Phrases',
                'Grammar',
                'Parts of Speech',
                'Tenses',
                'Sentence Structure',
              ],
              estimatedQuestions: 25,
            ),
            Topic(
              id: 'eng_topic_005',
              name: 'Oral English',
              subtopics: [
                'Pronunciation',
                'Stress and Intonation',
                'Vowel and Consonant Sounds',
              ],
              estimatedQuestions: 15,
            ),
          ],
        ),
      ],
    );
  }

  static Subject _generalMathematics() {
    return Subject(
      id: 'math_001',
      name: 'General Mathematics',
      code: '402',
      category: SubjectCategory.compulsory,
      isCompulsory: true,
      description: 'Core mathematics for all students',
      syllabuses: [
        Syllabus(
          id: 'math_waec_2025',
          subjectId: 'math_001',
          examBody: ExamBody.waec,
          year: 2025,
          aims: [
            'Develop mathematical competency and computational skills',
            'Understand mathematical concepts',
            'Apply mathematics to solve real-life problems',
          ],
          papers: [
            ExamPaper(
              id: 'math_paper1',
              name: 'Paper 1',
              type: PaperType.multipleChoice,
              duration: '1½ hours',
              totalMarks: 50,
              numberOfQuestions: 50,
              questionsToAnswer: 50,
              description: '50 Multiple Choice Questions',
            ),
            ExamPaper(
              id: 'math_paper2',
              name: 'Paper 2',
              type: PaperType.essay,
              duration: '2½ hours',
              totalMarks: 100,
              numberOfQuestions: 13,
              questionsToAnswer: 10,
              description: '13 Essay Questions (Answer 10)',
            ),
          ],
          topics: [
            Topic(
              id: 'math_topic_001',
              name: 'Number and Numeration',
              subtopics: [
                'Number bases',
                'Modular Arithmetic',
                'Fractions, Decimals and Approximations',
                'Indices',
                'Logarithms',
                'Sequence and Series (A.P. and G.P.)',
                'Sets',
                'Surds',
                'Matrices and Determinants',
                'Ratio, Proportions and Rates',
                'Percentages',
                'Variation',
              ],
              estimatedQuestions: 8,
            ),
            Topic(
              id: 'math_topic_002',
              name: 'Algebraic Processes',
              subtopics: [
                'Algebraic expressions',
                'Linear Equations',
                'Simultaneous Equations',
                'Quadratic Equations',
                'Linear Inequalities',
                'Algebraic Fractions',
                'Functions and Relations',
              ],
              estimatedQuestions: 6,
            ),
            Topic(
              id: 'math_topic_003',
              name: 'Mensuration',
              subtopics: [
                'Lengths and Perimeters',
                'Areas of plane shapes',
                'Surface areas of solids',
                'Volumes of solids',
                'Longitudes and Latitudes',
              ],
              estimatedQuestions: 5,
            ),
            Topic(
              id: 'math_topic_004',
              name: 'Plane Geometry',
              subtopics: [
                'Angles',
                'Triangles and Polygons',
                'Circles',
                'Construction',
                'Loci',
              ],
              estimatedQuestions: 5,
            ),
            Topic(
              id: 'math_topic_005',
              name: 'Coordinate Geometry',
              subtopics: [
                'The x-y plane',
                'Coordinates of points',
                'Graphs of linear and quadratic functions',
                'Distance between two points',
                'Midpoint of a line',
              ],
              estimatedQuestions: 3,
            ),
            Topic(
              id: 'math_topic_006',
              name: 'Trigonometry',
              subtopics: [
                'Sine, Cosine and Tangent',
                'Trigonometric ratios of special angles',
                'Angles of elevation and depression',
                'Bearings',
                'Sine and Cosine rules',
              ],
              estimatedQuestions: 5,
            ),
            Topic(
              id: 'math_topic_007',
              name: 'Introductory Calculus',
              subtopics: [
                'Differentiation',
                'Integration',
                'Maximum and minimum values',
                'Rates of change',
              ],
              estimatedQuestions: 3,
            ),
            Topic(
              id: 'math_topic_008',
              name: 'Statistics and Probability',
              subtopics: [
                'Frequency distribution',
                'Mean, Median, Mode',
                'Range and Standard deviation',
                'Pie charts and Bar charts',
                'Histograms',
                'Cumulative frequency',
                'Probability',
              ],
              estimatedQuestions: 5,
            ),
            Topic(
              id: 'math_topic_009',
              name: 'Vectors and Transformation',
              subtopics: [
                'Vectors in a plane',
                'Vector operations',
                'Reflection',
                'Rotation',
                'Translation',
                'Enlargement',
              ],
              estimatedQuestions: 3,
            ),
          ],
        ),
      ],
    );
  }

  static Subject _civicEducation() {
    return Subject(
      id: 'civic_001',
      name: 'Civic Education',
      code: '216',
      category: SubjectCategory.compulsory,
      isCompulsory: true,
      description: 'Understanding citizenship and national values',
      syllabuses: [
        Syllabus(
          id: 'civic_waec_2025',
          subjectId: 'civic_001',
          examBody: ExamBody.waec,
          year: 2025,
          aims: [
            'Develop civic consciousness',
            'Understand rights and responsibilities',
            'Promote national unity and integration',
          ],
          papers: [
            ExamPaper(
              id: 'civic_paper1',
              name: 'Paper 1',
              type: PaperType.multipleChoice,
              duration: '1 hour',
              totalMarks: 40,
              numberOfQuestions: 40,
              description: '40 Multiple Choice Questions',
            ),
            ExamPaper(
              id: 'civic_paper2',
              name: 'Paper 2',
              type: PaperType.essay,
              duration: '1½ hours',
              totalMarks: 60,
              numberOfQuestions: 6,
              questionsToAnswer: 4,
              description: '6 Essay Questions (Answer 4)',
            ),
          ],
          topics: [
            Topic(
              id: 'civic_topic_001',
              name: 'Citizenship',
              subtopics: [
                'Meaning of Citizenship',
                'Types of Citizenship',
                'Rights and Duties of Citizens',
              ],
              estimatedQuestions: 5,
            ),
            Topic(
              id: 'civic_topic_002',
              name: 'National Values and Symbols',
              subtopics: [
                'National Anthem',
                'National Pledge',
                'Coat of Arms',
                'National Flag',
              ],
              estimatedQuestions: 4,
            ),
            Topic(
              id: 'civic_topic_003',
              name: 'Democracy and Governance',
              subtopics: [
                'Meaning of Democracy',
                'Features of Democracy',
                'Types of Government',
                'Rule of Law',
              ],
              estimatedQuestions: 6,
            ),
            Topic(
              id: 'civic_topic_004',
              name: 'Human Rights',
              subtopics: [
                'Fundamental Human Rights',
                'Protection of Human Rights',
                'Agencies for Human Rights Protection',
              ],
              estimatedQuestions: 5,
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================================
  // SCIENCE SUBJECTS
  // ==========================================================================

  static Subject _physics() {
    return Subject(
      id: 'phy_001',
      name: 'Physics',
      code: '512',
      category: SubjectCategory.science,
      description: 'Study of matter, energy and their interactions',
      syllabuses: [
        Syllabus(
          id: 'phy_waec_2025',
          subjectId: 'phy_001',
          examBody: ExamBody.waec,
          year: 2025,
          aims: [
            'Develop interest in physics',
            'Acquire skills in practical physics',
            'Apply physics principles to solve problems',
          ],
          papers: [
            ExamPaper(
              id: 'phy_paper1',
              name: 'Paper 1',
              type: PaperType.multipleChoice,
              duration: '1 hour',
              totalMarks: 50,
              numberOfQuestions: 50,
              description: '50 Multiple Choice Questions',
            ),
            ExamPaper(
              id: 'phy_paper2',
              name: 'Paper 2',
              type: PaperType.essay,
              duration: '2 hours',
              totalMarks: 50,
              numberOfQuestions: 8,
              questionsToAnswer: 6,
              description: '8 Essay Questions (Answer 6)',
            ),
            ExamPaper(
              id: 'phy_paper3',
              name: 'Paper 3',
              type: PaperType.practical,
              duration: '2 hours',
              totalMarks: 50,
              description: 'Practical Physics',
            ),
          ],
          topics: [
            Topic(
              id: 'phy_topic_001',
              name: 'Mechanics',
              subtopics: [
                'Motion',
                'Scalars and Vectors',
                'Force',
                'Work, Energy and Power',
                'Momentum',
                'Machines',
                'Equilibrium of Forces',
              ],
              estimatedQuestions: 10,
            ),
            Topic(
              id: 'phy_topic_002',
              name: 'Heat Energy',
              subtopics: [
                'Temperature',
                'Thermal Expansion',
                'Heat Capacity',
                'Latent Heat',
                'Heat Transfer',
                'Gas Laws',
              ],
              estimatedQuestions: 8,
            ),
            Topic(
              id: 'phy_topic_003',
              name: 'Waves and Sound',
              subtopics: [
                'Wave Motion',
                'Properties of Waves',
                'Sound Waves',
                'Reflection and Refraction',
              ],
              estimatedQuestions: 7,
            ),
            Topic(
              id: 'phy_topic_004',
              name: 'Light',
              subtopics: [
                'Reflection of Light',
                'Refraction of Light',
                'Lenses',
                'Optical Instruments',
                'Dispersion',
              ],
              estimatedQuestions: 7,
            ),
            Topic(
              id: 'phy_topic_005',
              name: 'Electricity and Magnetism',
              subtopics: [
                'Static Electricity',
                'Electric Circuits',
                'Ohms Law',
                'Electrical Energy and Power',
                'Magnetism',
                'Electromagnetic Induction',
              ],
              estimatedQuestions: 10,
            ),
            Topic(
              id: 'phy_topic_006',
              name: 'Modern Physics',
              subtopics: [
                'Atomic Structure',
                'Radioactivity',
                'Nuclear Energy',
                'Electronics',
              ],
              estimatedQuestions: 8,
            ),
          ],
        ),
      ],
    );
  }

  static Subject _chemistry() {
    return Subject(
      id: 'chem_001',
      name: 'Chemistry',
      code: '505',
      category: SubjectCategory.science,
      description: 'Study of matter and its transformations',
      syllabuses: [
        Syllabus(
          id: 'chem_waec_2025',
          subjectId: 'chem_001',
          examBody: ExamBody.waec,
          year: 2025,
          aims: [
            'Develop interest in chemistry',
            'Acquire practical chemistry skills',
            'Apply chemical principles to everyday life',
          ],
          papers: [
            ExamPaper(
              id: 'chem_paper1',
              name: 'Paper 1',
              type: PaperType.multipleChoice,
              duration: '1 hour',
              totalMarks: 50,
              numberOfQuestions: 50,
              description: '50 Multiple Choice Questions',
            ),
            ExamPaper(
              id: 'chem_paper2',
              name: 'Paper 2',
              type: PaperType.essay,
              duration: '2 hours',
              totalMarks: 50,
              numberOfQuestions: 8,
              questionsToAnswer: 6,
              description: '8 Essay Questions (Answer 6)',
            ),
            ExamPaper(
              id: 'chem_paper3',
              name: 'Paper 3',
              type: PaperType.practical,
              duration: '3 hours',
              totalMarks: 50,
              description: 'Practical Chemistry',
            ),
          ],
          topics: [
            Topic(
              id: 'chem_topic_001',
              name: 'Physical Chemistry',
              subtopics: [
                'Particulate Nature of Matter',
                'Atomic Structure',
                'Chemical Bonding',
                'States of Matter',
                'Solutions and Solubility',
                'Acids, Bases and Salts',
                'Oxidation and Reduction',
                'Electrolysis',
                'Energy Changes',
                'Reaction Rates',
                'Chemical Equilibrium',
              ],
              estimatedQuestions: 15,
            ),
            Topic(
              id: 'chem_topic_002',
              name: 'Inorganic Chemistry',
              subtopics: [
                'Periodic Table',
                'Metals',
                'Non-metals',
                'Water and Air',
                'Hydrogen',
                'Oxygen',
                'Nitrogen',
                'Sulphur',
                'Carbon',
              ],
              estimatedQuestions: 12,
            ),
            Topic(
              id: 'chem_topic_003',
              name: 'Organic Chemistry',
              subtopics: [
                'Hydrocarbons',
                'Alkanes',
                'Alkenes',
                'Alkynes',
                'Alcohols',
                'Organic Acids',
                'Esters',
                'Proteins and Enzymes',
                'Fats and Oils',
                'Carbohydrates',
                'Polymers',
                'Soap and Detergents',
              ],
              estimatedQuestions: 13,
            ),
            Topic(
              id: 'chem_topic_004',
              name: 'Chemical Calculations',
              subtopics: [
                'Mole Concept',
                'Empirical and Molecular Formula',
                'Chemical Equations',
                'Stoichiometry',
              ],
              estimatedQuestions: 10,
            ),
          ],
        ),
      ],
    );
  }

  static Subject _biology() {
    return Subject(
      id: 'bio_001',
      name: 'Biology',
      code: '504',
      category: SubjectCategory.science,
      description: 'Study of living organisms',
      syllabuses: [
        Syllabus(
          id: 'bio_waec_2025',
          subjectId: 'bio_001',
          examBody: ExamBody.waec,
          year: 2025,
          aims: [
            'Develop interest in biology',
            'Acquire biological skills and techniques',
            'Show concern for the environment',
          ],
          papers: [
            ExamPaper(
              id: 'bio_paper1',
              name: 'Paper 1',
              type: PaperType.multipleChoice,
              duration: '1 hour',
              totalMarks: 50,
              numberOfQuestions: 50,
              description: '50 Multiple Choice Questions',
            ),
            ExamPaper(
              id: 'bio_paper2',
              name: 'Paper 2',
              type: PaperType.essay,
              duration: '2 hours',
              totalMarks: 50,
              numberOfQuestions: 8,
              questionsToAnswer: 6,
              description: '8 Essay Questions (Answer 6)',
            ),
            ExamPaper(
              id: 'bio_paper3',
              name: 'Paper 3',
              type: PaperType.practical,
              duration: '2 hours',
              totalMarks: 50,
              description: 'Practical Biology',
            ),
          ],
          topics: [
            Topic(
              id: 'bio_topic_001',
              name: 'Cell Biology',
              subtopics: [
                'Cell Structure',
                'Cell Division',
                'Cell Membrane',
                'Osmosis and Diffusion',
              ],
              estimatedQuestions: 6,
            ),
            Topic(
              id: 'bio_topic_002',
              name: 'Genetics',
              subtopics: [
                'Heredity',
                'Mendels Laws',
                'DNA and RNA',
                'Genetic Engineering',
                'Variation',
              ],
              estimatedQuestions: 7,
            ),
            Topic(
              id: 'bio_topic_003',
              name: 'Evolution',
              subtopics: [
                'Theories of Evolution',
                'Evidence of Evolution',
                'Adaptation',
              ],
              estimatedQuestions: 4,
            ),
            Topic(
              id: 'bio_topic_004',
              name: 'Ecology',
              subtopics: [
                'Ecosystem',
                'Food Chains and Webs',
                'Population',
                'Conservation',
                'Pollution',
              ],
              estimatedQuestions: 6,
            ),
            Topic(
              id: 'bio_topic_005',
              name: 'Human Biology',
              subtopics: [
                'Nutrition',
                'Respiration',
                'Circulation',
                'Excretion',
                'Nervous System',
                'Hormones',
                'Reproduction',
                'Sense Organs',
              ],
              estimatedQuestions: 15,
            ),
            Topic(
              id: 'bio_topic_006',
              name: 'Plant Biology',
              subtopics: [
                'Plant Structure',
                'Photosynthesis',
                'Transpiration',
                'Plant Reproduction',
                'Plant Hormones',
              ],
              estimatedQuestions: 12,
            ),
          ],
        ),
      ],
    );
  }

  static Subject _furtherMathematics() {
    return Subject(
      id: 'fmath_001',
      name: 'Further Mathematics',
      code: '401',
      category: SubjectCategory.science,
      description: 'Advanced mathematics for science students',
      syllabuses: [
        Syllabus(
          id: 'fmath_waec_2025',
          subjectId: 'fmath_001',
          examBody: ExamBody.waec,
          year: 2025,
          aims: [
            'Develop advanced mathematical skills',
            'Prepare for tertiary education in mathematics-related fields',
          ],
          papers: [
            ExamPaper(
              id: 'fmath_paper1',
              name: 'Paper 1',
              type: PaperType.multipleChoice,
              duration: '1½ hours',
              totalMarks: 50,
              numberOfQuestions: 50,
              description: '50 Multiple Choice Questions',
            ),
            ExamPaper(
              id: 'fmath_paper2',
              name: 'Paper 2',
              type: PaperType.essay,
              duration: '2½ hours',
              totalMarks: 100,
              numberOfQuestions: 13,
              questionsToAnswer: 10,
              description: '13 Essay Questions (Answer 10)',
            ),
          ],
          topics: [
            Topic(
              id: 'fmath_topic_001',
              name: 'Advanced Algebra',
              subtopics: [
                'Polynomials',
                'Partial Fractions',
                'Binomial Theorem',
                'Mathematical Induction',
              ],
              estimatedQuestions: 6,
            ),
            Topic(
              id: 'fmath_topic_002',
              name: 'Calculus',
              subtopics: [
                'Differentiation',
                'Integration',
                'Applications of Calculus',
                'Differential Equations',
              ],
              estimatedQuestions: 8,
            ),
            Topic(
              id: 'fmath_topic_003',
              name: 'Vectors and Mechanics',
              subtopics: [
                'Vector Algebra',
                'Kinematics',
                'Dynamics',
                'Statics',
              ],
              estimatedQuestions: 7,
            ),
            Topic(
              id: 'fmath_topic_004',
              name: 'Matrices and Determinants',
              subtopics: [
                'Matrix Operations',
                'Inverse of Matrices',
                'Linear Transformations',
              ],
              estimatedQuestions: 5,
            ),
            Topic(
              id: 'fmath_topic_005',
              name: 'Trigonometry',
              subtopics: [
                'Trigonometric Identities',
                'Trigonometric Equations',
                'Compound Angles',
              ],
              estimatedQuestions: 6,
            ),
          ],
        ),
      ],
    );
  }

  static Subject _agriculturalScience() {
    return Subject(
      id: 'agric_001',
      name: 'Agricultural Science',
      code: '502',
      category: SubjectCategory.science,
      description: 'Study of agricultural practices and principles',
      syllabuses: [
        Syllabus(
          id: 'agric_waec_2025',
          subjectId: 'agric_001',
          examBody: ExamBody.waec,
          year: 2025,
          aims: [
            'Develop skills in agricultural practices',
            'Understand agricultural economics',
            'Promote entrepreneurship in agriculture',
          ],
          papers: [
            ExamPaper(
              id: 'agric_paper1',
              name: 'Paper 1',
              type: PaperType.multipleChoice,
              duration: '1 hour',
              totalMarks: 50,
              numberOfQuestions: 50,
              description: '50 Multiple Choice Questions',
            ),
            ExamPaper(
              id: 'agric_paper2',
              name: 'Paper 2',
              type: PaperType.essay,
              duration: '2 hours',
              totalMarks: 50,
              numberOfQuestions: 8,
              questionsToAnswer: 6,
              description: '8 Essay Questions (Answer 6)',
            ),
            ExamPaper(
              id: 'agric_paper3',
              name: 'Paper 3',
              type: PaperType.practical,
              duration: '2 hours',
              totalMarks: 50,
              description: 'Practical Agriculture',
            ),
          ],
          topics: [
            Topic(
              id: 'agric_topic_001',
              name: 'Crop Production',
              subtopics: [
                'Land Preparation',
                'Planting',
                'Crop Management',
                'Harvesting',
                'Storage',
              ],
              estimatedQuestions: 10,
            ),
            Topic(
              id: 'agric_topic_002',
              name: 'Animal Production',
              subtopics: [
                'Animal Husbandry',
                'Breeds of Livestock',
                'Animal Nutrition',
                'Animal Health',
              ],
              estimatedQuestions: 10,
            ),
            Topic(
              id: 'agric_topic_003',
              name: 'Soil Science',
              subtopics: [
                'Soil Formation',
                'Soil Types',
                'Soil Fertility',
                'Soil Conservation',
              ],
              estimatedQuestions: 8,
            ),
            Topic(
              id: 'agric_topic_004',
              name: 'Farm Mechanization',
              subtopics: [
                'Farm Tools and Equipment',
                'Farm Machinery',
                'Irrigation Systems',
              ],
              estimatedQuestions: 6,
            ),
            Topic(
              id: 'agric_topic_005',
              name: 'Agricultural Economics',
              subtopics: [
                'Farm Management',
                'Marketing',
                'Agricultural Finance',
              ],
              estimatedQuestions: 6,
            ),
          ],
        ),
      ],
    );
  }

  static Subject _healthEducation() {
    return Subject(
      id: 'health_001',
      name: 'Health Education',
      code: '508',
      category: SubjectCategory.science,
      description: 'Understanding health and wellness',
      syllabuses: [
        Syllabus(
          id: 'health_waec_2025',
          subjectId: 'health_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'health_topic_001',
              name: 'Personal Health',
              subtopics: ['Hygiene', 'Nutrition', 'Exercise'],
            ),
            Topic(
              id: 'health_topic_002',
              name: 'Diseases and Prevention',
              subtopics: ['Communicable Diseases', 'Non-communicable Diseases'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _physicalEducation() {
    return Subject(
      id: 'pe_001',
      name: 'Physical Education',
      code: '511',
      category: SubjectCategory.science,
      description: 'Study of physical fitness and sports',
      syllabuses: [
        Syllabus(
          id: 'pe_waec_2025',
          subjectId: 'pe_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'pe_topic_001',
              name: 'Track and Field Events',
              subtopics: ['Running', 'Jumping', 'Throwing'],
            ),
            Topic(
              id: 'pe_topic_002',
              name: 'Team Sports',
              subtopics: ['Football', 'Basketball', 'Volleyball'],
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================================
  // ARTS/HUMANITIES SUBJECTS
  // ==========================================================================

  static Subject _literatureInEnglish() {
    return Subject(
      id: 'lit_001',
      name: 'Literature in English',
      code: '210',
      category: SubjectCategory.arts,
      description: 'Study of English literary works',
      syllabuses: [
        Syllabus(
          id: 'lit_waec_2025',
          subjectId: 'lit_001',
          examBody: ExamBody.waec,
          year: 2025,
          aims: [
            'Develop appreciation for literature',
            'Understand literary devices and techniques',
            'Analyze and interpret literary texts',
          ],
          papers: [
            ExamPaper(
              id: 'lit_paper1',
              name: 'Paper 1',
              type: PaperType.multipleChoice,
              duration: '1 hour',
              totalMarks: 50,
              numberOfQuestions: 50,
              description: '50 Objective Questions',
            ),
            ExamPaper(
              id: 'lit_paper2',
              name: 'Paper 2',
              type: PaperType.essay,
              duration: '2 hours',
              totalMarks: 50,
              numberOfQuestions: 6,
              questionsToAnswer: 4,
              description: 'Drama and Poetry',
            ),
            ExamPaper(
              id: 'lit_paper3',
              name: 'Paper 3',
              type: PaperType.essay,
              duration: '2 hours',
              totalMarks: 50,
              numberOfQuestions: 6,
              questionsToAnswer: 3,
              description: 'Prose',
            ),
          ],
          topics: [
            Topic(
              id: 'lit_topic_001',
              name: 'Poetry',
              subtopics: [
                'Poetic Devices',
                'Themes in Poetry',
                'African Poetry',
                'Non-African Poetry',
              ],
              estimatedQuestions: 15,
            ),
            Topic(
              id: 'lit_topic_002',
              name: 'Drama',
              subtopics: [
                'Elements of Drama',
                'Shakespeare',
                'African Drama',
                'Contemporary Drama',
              ],
              estimatedQuestions: 15,
            ),
            Topic(
              id: 'lit_topic_003',
              name: 'Prose',
              subtopics: [
                'Novel',
                'Short Story',
                'African Prose',
                'Non-African Prose',
              ],
              estimatedQuestions: 20,
            ),
          ],
        ),
      ],
    );
  }

  static Subject _government() {
    return Subject(
      id: 'gov_001',
      name: 'Government',
      code: '205',
      category: SubjectCategory.arts,
      description: 'Study of political systems and governance',
      syllabuses: [
        Syllabus(
          id: 'gov_waec_2025',
          subjectId: 'gov_001',
          examBody: ExamBody.waec,
          year: 2025,
          aims: [
            'Understand political concepts and institutions',
            'Analyze government systems',
            'Develop political awareness',
          ],
          papers: [
            ExamPaper(
              id: 'gov_paper1',
              name: 'Paper 1',
              type: PaperType.multipleChoice,
              duration: '1 hour',
              totalMarks: 50,
              numberOfQuestions: 50,
              description: '50 Multiple Choice Questions',
            ),
            ExamPaper(
              id: 'gov_paper2',
              name: 'Paper 2',
              type: PaperType.essay,
              duration: '2 hours',
              totalMarks: 100,
              numberOfQuestions: 8,
              questionsToAnswer: 5,
              description: '8 Essay Questions (Answer 5)',
            ),
          ],
          topics: [
            Topic(
              id: 'gov_topic_001',
              name: 'Political Theory',
              subtopics: [
                'Power and Authority',
                'Legitimacy',
                'Sovereignty',
                'Political Ideologies',
              ],
              estimatedQuestions: 8,
            ),
            Topic(
              id: 'gov_topic_002',
              name: 'Constitution',
              subtopics: [
                'Types of Constitution',
                'Constitutional Development',
                'Separation of Powers',
              ],
              estimatedQuestions: 7,
            ),
            Topic(
              id: 'gov_topic_003',
              name: 'Democracy',
              subtopics: [
                'Features of Democracy',
                'Electoral Systems',
                'Political Parties',
                'Pressure Groups',
              ],
              estimatedQuestions: 10,
            ),
            Topic(
              id: 'gov_topic_004',
              name: 'Public Administration',
              subtopics: [
                'Civil Service',
                'Public Corporations',
                'Local Government',
              ],
              estimatedQuestions: 8,
            ),
            Topic(
              id: 'gov_topic_005',
              name: 'International Relations',
              subtopics: [
                'Foreign Policy',
                'International Organizations',
                'Commonwealth',
              ],
              estimatedQuestions: 7,
            ),
          ],
        ),
      ],
    );
  }

  static Subject _history() {
    return Subject(
      id: 'hist_001',
      name: 'History',
      code: '207',
      category: SubjectCategory.arts,
      description: 'Study of past events and civilizations',
      syllabuses: [
        Syllabus(
          id: 'hist_waec_2025',
          subjectId: 'hist_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'hist_topic_001',
              name: 'Pre-colonial Africa',
              subtopics: ['African Kingdoms', 'Trade', 'Culture'],
            ),
            Topic(
              id: 'hist_topic_002',
              name: 'Colonialism',
              subtopics: ['Scramble for Africa', 'Colonial Administration'],
            ),
            Topic(
              id: 'hist_topic_003',
              name: 'Nationalism and Independence',
              subtopics: ['Independence Movements', 'Post-Independence'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _christianReligiousStudies() {
    return Subject(
      id: 'crs_001',
      name: 'Christian Religious Studies',
      code: '202',
      category: SubjectCategory.arts,
      description: 'Study of Christian teachings and principles',
      syllabuses: [
        Syllabus(
          id: 'crs_waec_2025',
          subjectId: 'crs_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'crs_topic_001',
              name: 'Old Testament',
              subtopics: ['Creation', 'Prophets', 'Kings'],
            ),
            Topic(
              id: 'crs_topic_002',
              name: 'New Testament',
              subtopics: ['Life of Jesus', 'Apostles', 'Early Church'],
            ),
            Topic(
              id: 'crs_topic_003',
              name: 'Christian Ethics',
              subtopics: ['Moral Values', 'Christian Living'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _islamicStudies() {
    return Subject(
      id: 'isl_001',
      name: 'Islamic Studies',
      code: '208',
      category: SubjectCategory.arts,
      description: 'Study of Islamic teachings and principles',
      syllabuses: [
        Syllabus(
          id: 'isl_waec_2025',
          subjectId: 'isl_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'isl_topic_001',
              name: 'Quran and Hadith',
              subtopics: ['Revelation', 'Prophets', 'Islamic Law'],
            ),
            Topic(
              id: 'isl_topic_002',
              name: 'Islamic History',
              subtopics: ['Early Islam', 'Caliphs', 'Islamic Civilization'],
            ),
            Topic(
              id: 'isl_topic_003',
              name: 'Islamic Ethics',
              subtopics: ['Moral Values', 'Islamic Living'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _music() {
    return Subject(
      id: 'music_001',
      name: 'Music',
      code: '705',
      category: SubjectCategory.arts,
      description: 'Study of music theory and practice',
      syllabuses: [
        Syllabus(
          id: 'music_waec_2025',
          subjectId: 'music_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'music_topic_001',
              name: 'Music Theory',
              subtopics: ['Notation', 'Scales', 'Chords'],
            ),
            Topic(
              id: 'music_topic_002',
              name: 'African Music',
              subtopics: ['Traditional Music', 'Instruments'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _visualArt() {
    return Subject(
      id: 'art_001',
      name: 'Visual Art',
      code: '706',
      category: SubjectCategory.arts,
      description: 'Study of visual arts and design',
      syllabuses: [
        Syllabus(
          id: 'art_waec_2025',
          subjectId: 'art_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'art_topic_001',
              name: 'Drawing and Painting',
              subtopics: ['Still Life', 'Life Drawing', 'Composition'],
            ),
            Topic(
              id: 'art_topic_002',
              name: 'Graphics and Design',
              subtopics: ['Typography', 'Layout Design'],
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================================
  // LANGUAGES
  // ==========================================================================

  static Subject _arabic() {
    return Subject(
      id: 'arab_001',
      name: 'Arabic',
      code: '301',
      category: SubjectCategory.languages,
      description: 'Study of Arabic language',
      syllabuses: [
        Syllabus(
          id: 'arab_waec_2025',
          subjectId: 'arab_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'arab_topic_001',
              name: 'Grammar',
              subtopics: ['Sentence Structure', 'Verb Conjugation'],
            ),
            Topic(
              id: 'arab_topic_002',
              name: 'Comprehension',
              subtopics: ['Reading', 'Translation'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _french() {
    return Subject(
      id: 'french_001',
      name: 'French',
      code: '304',
      category: SubjectCategory.languages,
      description: 'Study of French language',
      syllabuses: [
        Syllabus(
          id: 'french_waec_2025',
          subjectId: 'french_001',
          examBody: ExamBody.waec,
          year: 2025,
          aims: [
            'Develop proficiency in French',
            'Understand French culture',
          ],
          papers: [
            ExamPaper(
              id: 'french_paper1',
              name: 'Paper 1',
              type: PaperType.essay,
              duration: '2½ hours',
              totalMarks: 100,
              description: 'Essay and Comprehension',
            ),
            ExamPaper(
              id: 'french_paper2',
              name: 'Paper 2',
              type: PaperType.multipleChoice,
              duration: '1½ hours',
              totalMarks: 50,
              numberOfQuestions: 50,
              description: 'Grammar and Vocabulary',
            ),
            ExamPaper(
              id: 'french_paper3',
              name: 'Paper 3',
              type: PaperType.oral,
              duration: '30 minutes',
              totalMarks: 50,
              description: 'Oral French',
            ),
          ],
          topics: [
            Topic(
              id: 'french_topic_001',
              name: 'Grammar',
              subtopics: ['Tenses', 'Articles', 'Pronouns', 'Adjectives'],
              estimatedQuestions: 20,
            ),
            Topic(
              id: 'french_topic_002',
              name: 'Comprehension',
              subtopics: ['Reading', 'Translation', 'Summary'],
              estimatedQuestions: 15,
            ),
            Topic(
              id: 'french_topic_003',
              name: 'Essay Writing',
              subtopics: ['Letter Writing', 'Composition'],
              estimatedQuestions: 10,
            ),
          ],
        ),
      ],
    );
  }

  static Subject _hausa() {
    return Subject(
      id: 'hausa_001',
      name: 'Hausa',
      code: '327',
      category: SubjectCategory.languages,
      description: 'Study of Hausa language',
      syllabuses: [
        Syllabus(
          id: 'hausa_waec_2025',
          subjectId: 'hausa_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'hausa_topic_001',
              name: 'Grammar',
              subtopics: ['Sentence Structure', 'Verb Forms'],
            ),
            Topic(
              id: 'hausa_topic_002',
              name: 'Literature',
              subtopics: ['Poetry', 'Prose', 'Drama'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _igbo() {
    return Subject(
      id: 'igbo_001',
      name: 'Igbo',
      code: '328',
      category: SubjectCategory.languages,
      description: 'Study of Igbo language',
      syllabuses: [
        Syllabus(
          id: 'igbo_waec_2025',
          subjectId: 'igbo_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'igbo_topic_001',
              name: 'Grammar',
              subtopics: ['Sentence Structure', 'Verb Forms'],
            ),
            Topic(
              id: 'igbo_topic_002',
              name: 'Literature',
              subtopics: ['Poetry', 'Prose', 'Drama'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _yoruba() {
    return Subject(
      id: 'yoruba_001',
      name: 'Yoruba',
      code: '329',
      category: SubjectCategory.languages,
      description: 'Study of Yoruba language',
      syllabuses: [
        Syllabus(
          id: 'yoruba_waec_2025',
          subjectId: 'yoruba_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'yoruba_topic_001',
              name: 'Grammar',
              subtopics: ['Sentence Structure', 'Verb Forms'],
            ),
            Topic(
              id: 'yoruba_topic_002',
              name: 'Literature',
              subtopics: ['Poetry', 'Prose', 'Drama'],
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================================
  // COMMERCIAL/BUSINESS/SOCIAL SCIENCE
  // ==========================================================================

  static Subject _economics() {
    return Subject(
      id: 'econ_001',
      name: 'Economics',
      code: '203',
      category: SubjectCategory.commercial,
      description: 'Study of economic principles and systems',
      syllabuses: [
        Syllabus(
          id: 'econ_waec_2025',
          subjectId: 'econ_001',
          examBody: ExamBody.waec,
          year: 2025,
          aims: [
            'Understand economic concepts',
            'Apply economic principles to real-world situations',
            'Develop analytical skills',
          ],
          papers: [
            ExamPaper(
              id: 'econ_paper1',
              name: 'Paper 1',
              type: PaperType.multipleChoice,
              duration: '1 hour',
              totalMarks: 50,
              numberOfQuestions: 50,
              description: '50 Multiple Choice Questions',
            ),
            ExamPaper(
              id: 'econ_paper2',
              name: 'Paper 2',
              type: PaperType.essay,
              duration: '2½ hours',
              totalMarks: 100,
              numberOfQuestions: 8,
              questionsToAnswer: 6,
              description: '8 Essay Questions (Answer 6)',
            ),
          ],
          topics: [
            Topic(
              id: 'econ_topic_001',
              name: 'Basic Economic Concepts',
              subtopics: [
                'Scarcity and Choice',
                'Opportunity Cost',
                'Scale of Preference',
                'Economic Systems',
              ],
              estimatedQuestions: 8,
            ),
            Topic(
              id: 'econ_topic_002',
              name: 'Theory of Production',
              subtopics: [
                'Factors of Production',
                'Division of Labour',
                'Law of Diminishing Returns',
                'Production Possibility Curve',
              ],
              estimatedQuestions: 7,
            ),
            Topic(
              id: 'econ_topic_003',
              name: 'Theory of Demand and Supply',
              subtopics: [
                'Demand',
                'Supply',
                'Equilibrium',
                'Elasticity',
              ],
              estimatedQuestions: 10,
            ),
            Topic(
              id: 'econ_topic_004',
              name: 'Market Structure',
              subtopics: [
                'Perfect Competition',
                'Monopoly',
                'Oligopoly',
                'Monopolistic Competition',
              ],
              estimatedQuestions: 6,
            ),
            Topic(
              id: 'econ_topic_005',
              name: 'Money and Banking',
              subtopics: [
                'Functions of Money',
                'Commercial Banks',
                'Central Banks',
                'Monetary Policy',
              ],
              estimatedQuestions: 8,
            ),
            Topic(
              id: 'econ_topic_006',
              name: 'International Trade',
              subtopics: [
                'Balance of Trade',
                'Balance of Payments',
                'Exchange Rates',
                'Trade Restrictions',
              ],
              estimatedQuestions: 7,
            ),
            Topic(
              id: 'econ_topic_007',
              name: 'Public Finance',
              subtopics: [
                'Government Revenue',
                'Government Expenditure',
                'National Budget',
                'Taxation',
              ],
              estimatedQuestions: 4,
            ),
          ],
        ),
      ],
    );
  }

  static Subject _commerce() {
    return Subject(
      id: 'comm_001',
      name: 'Commerce',
      code: '103',
      category: SubjectCategory.commercial,
      description: 'Study of trade and commercial activities',
      syllabuses: [
        Syllabus(
          id: 'comm_waec_2025',
          subjectId: 'comm_001',
          examBody: ExamBody.waec,
          year: 2025,
          aims: [
            'Understand commercial activities',
            'Develop business skills',
            'Prepare for business careers',
          ],
          papers: [
            ExamPaper(
              id: 'comm_paper1',
              name: 'Paper 1',
              type: PaperType.multipleChoice,
              duration: '1 hour',
              totalMarks: 50,
              numberOfQuestions: 50,
              description: '50 Multiple Choice Questions',
            ),
            ExamPaper(
              id: 'comm_paper2',
              name: 'Paper 2',
              type: PaperType.essay,
              duration: '2 hours',
              totalMarks: 100,
              numberOfQuestions: 8,
              questionsToAnswer: 6,
              description: '8 Essay Questions (Answer 6)',
            ),
          ],
          topics: [
            Topic(
              id: 'comm_topic_001',
              name: 'Trade',
              subtopics: [
                'Types of Trade',
                'Home Trade',
                'Foreign Trade',
                'Wholesale and Retail',
              ],
              estimatedQuestions: 8,
            ),
            Topic(
              id: 'comm_topic_002',
              name: 'Transportation',
              subtopics: [
                'Modes of Transport',
                'Road Transport',
                'Rail Transport',
                'Air Transport',
                'Water Transport',
              ],
              estimatedQuestions: 7,
            ),
            Topic(
              id: 'comm_topic_003',
              name: 'Warehousing',
              subtopics: [
                'Functions of Warehousing',
                'Types of Warehouses',
                'Documents in Warehousing',
              ],
              estimatedQuestions: 5,
            ),
            Topic(
              id: 'comm_topic_004',
              name: 'Insurance',
              subtopics: [
                'Principles of Insurance',
                'Types of Insurance',
                'Insurance Documents',
              ],
              estimatedQuestions: 7,
            ),
            Topic(
              id: 'comm_topic_005',
              name: 'Banking',
              subtopics: [
                'Types of Banks',
                'Banking Services',
                'Banking Documents',
              ],
              estimatedQuestions: 8,
            ),
            Topic(
              id: 'comm_topic_006',
              name: 'Communication',
              subtopics: [
                'Means of Communication',
                'Postal Services',
                'Telecommunication',
              ],
              estimatedQuestions: 5,
            ),
            Topic(
              id: 'comm_topic_007',
              name: 'Business Documents',
              subtopics: [
                'Invoice',
                'Receipt',
                'Statement of Account',
                'Credit Note',
                'Debit Note',
              ],
              estimatedQuestions: 10,
            ),
          ],
        ),
      ],
    );
  }

  static Subject _financialAccounting() {
    return Subject(
      id: 'acc_001',
      name: 'Financial Accounting',
      code: '104',
      category: SubjectCategory.commercial,
      description: 'Study of accounting principles and practices',
      syllabuses: [
        Syllabus(
          id: 'acc_waec_2025',
          subjectId: 'acc_001',
          examBody: ExamBody.waec,
          year: 2025,
          aims: [
            'Understand accounting principles',
            'Prepare financial statements',
            'Develop accounting skills',
          ],
          papers: [
            ExamPaper(
              id: 'acc_paper1',
              name: 'Paper 1',
              type: PaperType.multipleChoice,
              duration: '1 hour',
              totalMarks: 50,
              numberOfQuestions: 50,
              description: '50 Multiple Choice Questions',
            ),
            ExamPaper(
              id: 'acc_paper2',
              name: 'Paper 2',
              type: PaperType.essay,
              duration: '3 hours',
              totalMarks: 100,
              numberOfQuestions: 7,
              questionsToAnswer: 6,
              description: '7 Essay Questions (Answer 6)',
            ),
          ],
          topics: [
            Topic(
              id: 'acc_topic_001',
              name: 'Introduction to Accounting',
              subtopics: [
                'Accounting Concepts',
                'Accounting Principles',
                'Double Entry System',
                'Books of Original Entry',
              ],
              estimatedQuestions: 6,
            ),
            Topic(
              id: 'acc_topic_002',
              name: 'Financial Statements',
              subtopics: [
                'Trading Account',
                'Profit and Loss Account',
                'Balance Sheet',
                'Cash Flow Statement',
              ],
              estimatedQuestions: 12,
            ),
            Topic(
              id: 'acc_topic_003',
              name: 'Manufacturing Accounts',
              subtopics: [
                'Prime Cost',
                'Factory Overhead',
                'Cost of Production',
              ],
              estimatedQuestions: 5,
            ),
            Topic(
              id: 'acc_topic_004',
              name: 'Partnership Accounts',
              subtopics: [
                'Formation of Partnership',
                'Profit and Loss Appropriation',
                'Admission of Partners',
                'Dissolution',
              ],
              estimatedQuestions: 8,
            ),
            Topic(
              id: 'acc_topic_005',
              name: 'Company Accounts',
              subtopics: [
                'Share Capital',
                'Debentures',
                'Final Accounts of Companies',
              ],
              estimatedQuestions: 7,
            ),
            Topic(
              id: 'acc_topic_006',
              name: 'Departmental Accounts',
              subtopics: [
                'Departmental Trading Account',
                'Departmental Profit and Loss',
              ],
              estimatedQuestions: 4,
            ),
            Topic(
              id: 'acc_topic_007',
              name: 'Control Accounts',
              subtopics: [
                'Debtors Control Account',
                'Creditors Control Account',
              ],
              estimatedQuestions: 8,
            ),
          ],
        ),
      ],
    );
  }

  static Subject _geography() {
    return Subject(
      id: 'geo_001',
      name: 'Geography',
      code: '204',
      category: SubjectCategory.commercial,
      description: 'Study of physical and human geography',
      syllabuses: [
        Syllabus(
          id: 'geo_waec_2025',
          subjectId: 'geo_001',
          examBody: ExamBody.waec,
          year: 2025,
          aims: [
            'Understand geographical concepts',
            'Develop map reading skills',
            'Analyze human-environment interactions',
          ],
          papers: [
            ExamPaper(
              id: 'geo_paper1',
              name: 'Paper 1',
              type: PaperType.multipleChoice,
              duration: '1 hour',
              totalMarks: 50,
              numberOfQuestions: 50,
              description: '50 Multiple Choice Questions',
            ),
            ExamPaper(
              id: 'geo_paper2',
              name: 'Paper 2',
              type: PaperType.essay,
              duration: '2½ hours',
              totalMarks: 100,
              numberOfQuestions: 9,
              questionsToAnswer: 6,
              description: '9 Essay Questions (Answer 6)',
            ),
            ExamPaper(
              id: 'geo_paper3',
              name: 'Paper 3',
              type: PaperType.practical,
              duration: '2 hours',
              totalMarks: 50,
              description: 'Practical Geography - Map Reading',
            ),
          ],
          topics: [
            Topic(
              id: 'geo_topic_001',
              name: 'Physical Geography',
              subtopics: [
                'Landforms',
                'Weather and Climate',
                'Vegetation',
                'Soils',
                'Water Bodies',
              ],
              estimatedQuestions: 12,
            ),
            Topic(
              id: 'geo_topic_002',
              name: 'Human Geography',
              subtopics: [
                'Population',
                'Settlement',
                'Agriculture',
                'Industries',
                'Transportation',
              ],
              estimatedQuestions: 13,
            ),
            Topic(
              id: 'geo_topic_003',
              name: 'Map Reading',
              subtopics: [
                'Scale',
                'Bearings',
                'Relief',
                'Cross Sections',
                'Topographic Maps',
              ],
              estimatedQuestions: 15,
            ),
            Topic(
              id: 'geo_topic_004',
              name: 'Environmental Studies',
              subtopics: [
                'Pollution',
                'Conservation',
                'Climate Change',
              ],
              estimatedQuestions: 10,
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================================
  // TECHNICAL/VOCATIONAL
  // ==========================================================================

  static Subject _technicalDrawing() {
    return Subject(
      id: 'tech_001',
      name: 'Technical Drawing',
      code: '608',
      category: SubjectCategory.technical,
      description: 'Study of engineering drawing and design',
      syllabuses: [
        Syllabus(
          id: 'tech_waec_2025',
          subjectId: 'tech_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'tech_topic_001',
              name: 'Geometric Construction',
              subtopics: ['Lines', 'Angles', 'Polygons'],
            ),
            Topic(
              id: 'tech_topic_002',
              name: 'Orthographic Projection',
              subtopics: ['First Angle', 'Third Angle'],
            ),
            Topic(
              id: 'tech_topic_003',
              name: 'Isometric Drawing',
              subtopics: ['Pictorial Views', '3D Representation'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _basicElectricity() {
    return Subject(
      id: 'elec_001',
      name: 'Basic Electricity',
      code: '614',
      category: SubjectCategory.technical,
      description: 'Fundamentals of electrical systems',
      syllabuses: [
        Syllabus(
          id: 'elec_waec_2025',
          subjectId: 'elec_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'elec_topic_001',
              name: 'Electric Circuits',
              subtopics: ['Series Circuits', 'Parallel Circuits'],
            ),
            Topic(
              id: 'elec_topic_002',
              name: 'Electrical Measurements',
              subtopics: ['Voltage', 'Current', 'Resistance'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _basicElectronics() {
    return Subject(
      id: 'electron_001',
      name: 'Basic Electronics',
      code: '615',
      category: SubjectCategory.technical,
      description: 'Fundamentals of electronic systems',
      syllabuses: [
        Syllabus(
          id: 'electron_waec_2025',
          subjectId: 'electron_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'electron_topic_001',
              name: 'Electronic Components',
              subtopics: ['Resistors', 'Capacitors', 'Diodes', 'Transistors'],
            ),
            Topic(
              id: 'electron_topic_002',
              name: 'Electronic Circuits',
              subtopics: ['Amplifiers', 'Oscillators'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _autoMechanics() {
    return Subject(
      id: 'auto_001',
      name: 'Auto Mechanics',
      code: '603',
      category: SubjectCategory.technical,
      description: 'Study of vehicle maintenance and repair',
      syllabuses: [
        Syllabus(
          id: 'auto_waec_2025',
          subjectId: 'auto_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'auto_topic_001',
              name: 'Engine Systems',
              subtopics: ['Internal Combustion', 'Engine Parts'],
            ),
            Topic(
              id: 'auto_topic_002',
              name: 'Vehicle Maintenance',
              subtopics: ['Servicing', 'Repairs'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _buildingConstruction() {
    return Subject(
      id: 'build_001',
      name: 'Building Construction',
      code: '604',
      category: SubjectCategory.technical,
      description: 'Study of construction methods and materials',
      syllabuses: [
        Syllabus(
          id: 'build_waec_2025',
          subjectId: 'build_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'build_topic_001',
              name: 'Building Materials',
              subtopics: ['Cement', 'Concrete', 'Timber', 'Steel'],
            ),
            Topic(
              id: 'build_topic_002',
              name: 'Construction Methods',
              subtopics: ['Foundations', 'Walls', 'Roofing'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _metalWork() {
    return Subject(
      id: 'metal_001',
      name: 'Metal Work',
      code: '607',
      category: SubjectCategory.technical,
      description: 'Study of metalworking techniques',
      syllabuses: [
        Syllabus(
          id: 'metal_waec_2025',
          subjectId: 'metal_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'metal_topic_001',
              name: 'Metal Fabrication',
              subtopics: ['Cutting', 'Joining', 'Forming'],
            ),
            Topic(
              id: 'metal_topic_002',
              name: 'Welding',
              subtopics: ['Arc Welding', 'Gas Welding'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _woodWork() {
    return Subject(
      id: 'wood_001',
      name: 'Woodwork',
      code: '609',
      category: SubjectCategory.technical,
      description: 'Study of woodworking techniques',
      syllabuses: [
        Syllabus(
          id: 'wood_waec_2025',
          subjectId: 'wood_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'wood_topic_001',
              name: 'Wood Joinery',
              subtopics: ['Joints', 'Fasteners'],
            ),
            Topic(
              id: 'wood_topic_002',
              name: 'Furniture Making',
              subtopics: ['Design', 'Construction'],
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================================
  // HOME ECONOMICS/VOCATIONAL
  // ==========================================================================

  static Subject _foodsAndNutrition() {
    return Subject(
      id: 'food_001',
      name: 'Foods and Nutrition',
      code: '702',
      category: SubjectCategory.homeEconomics,
      description: 'Study of food preparation and nutrition',
      syllabuses: [
        Syllabus(
          id: 'food_waec_2025',
          subjectId: 'food_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'food_topic_001',
              name: 'Nutrition',
              subtopics: ['Nutrients', 'Balanced Diet', 'Malnutrition'],
            ),
            Topic(
              id: 'food_topic_002',
              name: 'Food Preparation',
              subtopics: ['Cooking Methods', 'Food Preservation'],
            ),
            Topic(
              id: 'food_topic_003',
              name: 'Meal Planning',
              subtopics: ['Menu Planning', 'Food Service'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _clothingAndTextiles() {
    return Subject(
      id: 'cloth_001',
      name: 'Clothing and Textiles',
      code: '701',
      category: SubjectCategory.homeEconomics,
      description: 'Study of clothing construction and textiles',
      syllabuses: [
        Syllabus(
          id: 'cloth_waec_2025',
          subjectId: 'cloth_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'cloth_topic_001',
              name: 'Textiles',
              subtopics: ['Fibers', 'Fabrics', 'Fabric Care'],
            ),
            Topic(
              id: 'cloth_topic_002',
              name: 'Clothing Construction',
              subtopics: ['Pattern Making', 'Sewing Techniques'],
            ),
          ],
        ),
      ],
    );
  }

  static Subject _homeManagement() {
    return Subject(
      id: 'home_001',
      name: 'Home Management',
      code: '703',
      category: SubjectCategory.homeEconomics,
      description: 'Study of home and family management',
      syllabuses: [
        Syllabus(
          id: 'home_waec_2025',
          subjectId: 'home_001',
          examBody: ExamBody.waec,
          year: 2025,
          topics: [
            Topic(
              id: 'home_topic_001',
              name: 'Home Management',
              subtopics: ['Household Resources', 'Home Planning'],
            ),
            Topic(
              id: 'home_topic_002',
              name: 'Family Living',
              subtopics: ['Family Relationships', 'Child Development'],
            ),
          ],
        ),
      ],
    );
  }
}

// // ============================================================================
// // USAGE EXAMPLE
// // ============================================================================

// void macheckin() {
//   print('=== WAEC Subjects Data Loader ===\n');

//   // Load all subjects
//   final repository = SubjectDataHelper.loadAllSubjects();
//   print('✓ Loaded ${repository.getAllSubjects().length} subjects\n');

//   // Print summary
//   SubjectDataHelper.printSubjectsSummary();

//   // Get statistics
//   final stats = SubjectDataHelper.getStatistics();
//   print('=== Statistics ===');
//   print('Total Subjects: ${stats['totalSubjects']}');
//   print('Compulsory Subjects: ${stats['compulsorySubjects']}');
//   print('Total Topics: ${stats['totalTopics']}');
//   print('Total Subtopics: ${stats['totalSubtopics']}\n');

//   print('Category Distribution:');
//   (stats['categoryCounts'] as Map).forEach((category, count) {
//     print('  $category: $count');
//   });
//   print('');

//   // Example: Search for a subject
//   print('=== Search Example ===');
//   final mathSubject = repository.getSubjectByName('General Mathematics');
//   if (mathSubject != null) {
//     print('Found: ${mathSubject.name} (Code: ${mathSubject.code})');
//     print('Category: ${mathSubject.category.name}');
//     print('Compulsory: ${mathSubject.isCompulsory}');

//     // Get syllabus
//     final syllabus = mathSubject.getSyllabus(examBody: ExamBody.waec, year: 2025);
//     if (syllabus != null) {
//       print('Topics: ${syllabus.topics.length}');
//       print('\nFirst 3 Topics:');
//       for (var i = 0; i < 3 && i < syllabus.topics.length; i++) {
//         final topic = syllabus.topics[i];
//         print('  ${i + 1}. ${topic.name}');
//         print('     Subtopics: ${topic.subtopics.length}');
//       }
//     }
//   }
//   print('');

//   // Example: Get subjects by category
//   print('=== Science Subjects ===');
//   final scienceSubjects = repository.getSubjectsByCategory(SubjectCategory.science);
//   for (var subject in scienceSubjects) {
//     print('- ${subject.name} (${subject.code})');
//   }
//   print('');

//   // Example: Search topics across all subjects
//   print('=== Topic Search Example ===');
//   final results = repository.searchTopicsAcrossSubjects('algebra');
//   print('Found topics matching "algebra" in ${results.length} subjects:');
//   results.forEach((subject, topics) {
//     print('\n${subject.name}:');
//     for (var topic in topics) {
//       print('  - ${topic.name}');
//     }
//   });
//   print('');

//   // Example: Get compulsory subjects
//   print('=== Compulsory Subjects ===');
//   final compulsory = repository.getCompulsorySubjects();
//   for (var subject in compulsory) {
//     print('- ${subject.name} (${subject.code})');
//   }
//   print('');

//   print('✓ All examples completed successfully!');
// }
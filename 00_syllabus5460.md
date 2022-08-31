### Data Science for Biological Research: EBIO 5460

### Fall 2022

**Instructor**: Dr Brett Melbourne\
**Pronouns:** he, him, his\
**email:** [brett.melbourne\@colorado.edu](mailto:brett.melbourne@colorado.edu)\
**Office:** Ramaley N336 but mostly Zoom\
**Office hours:** Any time by appointment\
**Contacting me:** I prefer email\
**Class meeting times:** Monday & Wednesday 3:30-5 PM\
**Location:** Ramaley N183 and sometimes Zoom\
**Zoom details:**

-   Meeting ID: 969 8756 8909
-   In case you need to dial in:
    -   Find your local number: <https://cuboulder.zoom.us/u/acyOqFIhvC>

#### Course description

What is data science? The National Science Foundation defines data science as

> ... the science of planning for, acquisition, management, analysis of, and inference from data.

It further notes that

> Data science is inherently interdisciplinary. Working with data requires the mastery of a variety of skills and concepts, including many traditionally associated with the fields of statistics, computer science, and mathematics.

This is the philosophy of the course, applying an interdisciplinary approach to learning from data in biological research. We will take at least part of the working definition of data science to be a focus on algorithms and workflows to learn from data.


#### Topics

Skills:
- Version control using Git
- Project management and collaboration using GitHub
- Structured programming and debugging in R
- Manipulating data with tidyverse tools
- Visualization with ggplot
- Reproducible workflows
- Producing reports using markdown and knitr

Concepts, models, algorithms, computation:
- Frequentist, likelihood, Bayesian, information theoretic, predictionist
- Multilevel linear models, esp. generalized linear mixed models (GLMMs)
- Fitting mechanistic ecological models
- Stochastic simulation
- Bootstrap and other randomization approaches
- Cross validation
- Visualization theory
- Experimental and study design
- Introduction to machine learning


#### Where is it pitched?

This is a practical class. We are scientists of both biology and data. We need to learn from our data, so we need to use data science tools. Our aim is to understand the concepts, theory, and algorithms behind the main categories of data science tools and in particular be able to place an algorithm within a wider context, to understand connections among them, and to identify strengths and weaknesses in application. For example, how is a bootstrap related to a Bayesian posterior? How is k-fold cross validation related to AIC? How should I approach figuring out what mechanisms drive a species' response to climate change versus predicting how it will respond in 10 years? For that conceptual understanding and mastery we need some data science theory. I will develop an intuitive understanding of the foundational algorithms and concepts mostly through stochastic simulation and coding plus a bit of basic math. You will code and apply these algorithms to your own datasets. From this foundation you should be able to go deeper through self study.

#### Prerequisites

This is not a rank beginners class! You should have taken at least an introductory-level statistical modeling class covering linear models, preferably up to the level of Generalized Linear Models (GLM, e.g. logistic regression). An example of such a class is EBIO 4410/5410 "Biological Statistics". You needn't have R or coding experience, although it will be advantageous. If you're unsure if this class is for you, reach out to me.

#### The ultimate learning goal

You will be confident to use the skills and concepts above to plan for, acquire, manage, analyze, infer or predict from, and report about datasets of any size in your area of biological research.

#### Learning format

I'm envisioning a collaborative learning atmosphere. By this I don't mean only learning among yourselves from "knowledge" passed down from me to you. While data science and scientists doing data science have been around for decades before it came to be called "data science" it is also rapidly developing. We will explore some of these cutting-edge areas. The class is a hybrid of flipped and in-class lectures. I'll assign reading and video lectures or tutorials, some that I will produce, and some from others. In class we will largely focus on doing data science with real data. There will be few worksheets or rote labs. We will apply algorithms to our own data, including an individual project. We'll often create fake data too.

Hands on coding will often be done in small groups: collaboration is encouraged both in and out of class. I expect each person has different experience in different areas. I hope that we can create an environment that is relaxed and nonjudgmental so that we will all feel comfortable participating and also that all contributions are valued. I also hope that we can create an environment of respect for each other's learning processes and ideas.

#### Computing

You'll need access to computing. If you have a reasonably modern laptop, that's perfect. If you don't have access to computing please let me know as soon as possible. I can provide access to some great alternative compute resources.

#### R computing environment

Please upgrade to the latest versions of R and R Studio.

#### Texts

This class is a mash up and I will sample from several texts. You don't need to purchase any of these texts. Most of it is available free to you but not all of the textbook material can be posted publicly. Relevant sections will be posted to the class Google Drive folder.

The texts I will draw most heavily from and will be most useful are:

1)  McElreath, R (2020). *Statistical Rethinking: A Bayesian Course with Examples in R and Stan 2nd Ed.* CRC. Unfortunately it is not an open source text but the [book website](https://xcelab.net/rm/statistical-rethinking/) has links to video and R code that we'll make good use of. If you decide to purchase only one text, get this one. **No ebook version.**

2)  Gelman A & Hill J (2007) *Data Analysis Using Regression and Multilevel/Hierarchical Models.* Cambridge. Most of the examples are not from the natural sciences but it is excellent. We will use some of the chapters. Unfortunately this text is not open source but has a [website](http://www.stat.columbia.edu/~gelman/arm/) with data and R code. There is also an update to parts of this text just out: Gelman A, Hill J, Vehtari A (2021) *Regression and other stories.* Cambridge. We might use parts of this new version.

3)  James G, Witten D, Hastie T, Tibshirani R (2021). *An Introduction to Statistical Learning: With Applications in R, Second edition.* Springer, New York. You can download the pdf from the [book website](https://www.statlearning.com/) or through the library (see below). 

4)  Grolemund G & Wickham H (2017). *R for Data Science.* O'Reilly. This book is open source and can be accessed [here](http://r4ds.had.co.nz/).

5)  Wickham H (2016). *ggplot2: Elegant Graphics for Data Analysis, 2nd Ed.* Springer. Available online through the library (see below).

A text heavily influencing this course is Efron B & Hastie T (2016) *Computer Age Statistical Inference: Algorithms, Evidence, and Data Science.* Cambridge. This text is aimed at masters or first-year PhD students in statistics and data science. After completing this course, you might find this a useful book with a friendly level of math.

To find Springer texts through the CU library, do a Chinook search (you must be on the campus network or via VPN, not the guest wifi), follow the link to the ebook version (where you can download the full color pdf). You'll notice that there is also a Springer offer available through the library to buy a paperback version for $25. Beware: the special offer printed version is not in color (which is an issue for graphing data!).

#### Grading

Github portfolio of code commits, reading summaries, participation **50%** Individual assignment **50%**

#### Assignments

The individual assignment will be to use a multi-level Bayesian approach to analyze a dataset that you provide. It can be from your research, or from your lab, or from the literature (e.g. a reanalysis where the original study used older methods).

#### Exams

There will not be an exam. This material is not suited to exams.

#### GitHub

Almost everything will be on Github rather than Canvas. I have set up a GitHub organization that is restricted to our class (i.e. not public). Bookmark this URL: https://github.com/EBIO5460Fall2022.

All of your work will be tracked and submitted here (via a Git commit and push).

#### Your fieldwork

I realize that as graduate students you may have fieldwork or other research to complete during the semester. Please see me early on so we can talk about how we can work around your fieldwork.

#### My commitments

I possibly will need to travel for short periods for talks or fieldwork. If that happens I will endeavor to give the class via Zoom at the usual time. If I'm sometimes unable to attend the scheduled class time I will provide materials for these classes and you should show up and participate as usual.

#### Classroom behavior

Both students and faculty are responsible for maintaining an appropriate learning environment in all instructional settings, whether in person, remote or online. Those who fail to adhere to such behavioral standards may be subject to discipline. Professional courtesy and sensitivity are especially important with respect to individuals and topics dealing with race, color, national origin, sex, pregnancy, age, disability, creed, religion, sexual orientation, gender identity, gender expression, veteran status, political affiliation or political philosophy.  For more information, see the [classroom behavior policy](https://www.colorado.edu/policies/student-classroom-and-course-related-behavior), the [Student Code of Conduct](https://www.colorado.edu/sccr/student-conduct), and the [Office of Institutional Equity and Compliance](https://www.colorado.edu/oiec/).

#### Requirements for COVID-19

As a matter of public health and safety, all members of the CU Boulder community and all visitors to campus must follow university, department and building requirements and all public health orders in place to reduce the risk of spreading infectious disease. CU Boulder currently requires COVID-19 vaccination and boosters for all faculty, staff and students. Students, faculty and staff must upload proof of vaccination and boosters or file for an exemption based on medical, ethical or moral grounds through the MyCUHealth portal.

The CU Boulder campus is currently mask-optional. However, if public health conditions change and masks are again required in classrooms, students who fail to adhere to masking requirements will be asked to leave class, and students who do not leave class when asked or who refuse to comply with these requirements will be referred to Student Conduct and Conflict Resolution. For more information, see the policy on classroom behavior and the Student Code of Conduct. If you require accommodation because a disability prevents you from fulfilling these safety measures, please follow the steps in the “Accommodation for Disabilities” statement on this syllabus.

If you feel ill and think you might have COVID-19, if you have tested positive for COVID-19, or if you are unvaccinated or partially vaccinated and have been in close contact with someone who has COVID-19, you should stay home and follow the further guidance of the Public Health Office (contacttracing@colorado.edu). If you are fully vaccinated and have been in close contact with someone who has COVID-19, you do not need to stay home; rather, you should self-monitor for symptoms and follow the further guidance of the Public Health Office (contacttracing@colorado.edu). In this class, if you are sick or quarantined, please let me know as soon as possible so we can make a plan for you to continue participation and complete the course. You don't need to state the nature of your illness when alerting me.

#### Accommodation for disabilities

If you qualify for accommodations because of a disability, please submit your accommodation letter from Disability Services to your faculty member in a timely manner so that your needs can be addressed. Disability Services determines accommodations based on documented disabilities in the academic environment. Information on requesting accommodations is located on the [Disability Services website](https://www.colorado.edu/disabilityservices/). Contact Disability Services at 303-492-8671 or [dsinfo\@colorado.edu](mailto:dsinfo@colorado.edu) for further assistance. If you have a temporary medical condition, see [Temporary Medical Conditions](https://www.colorado.edu/disabilityservices/students/temporary-medical-conditions) on the Disability Services website.

#### Preferred student names and pronouns

CU Boulder recognizes that students' legal information doesn't always align with how they identify. Students may update their preferred names and pronouns via the student portal; those preferred names and pronouns are listed on instructors' class rosters. In the absence of such updates, the name that appears on the class roster is the student's legal name. I will gladly honor your request to address you by an alternate name or gender pronoun.

#### Honor code

All students enrolled in a University of Colorado Boulder course are responsible for knowing and adhering to the [Honor Code](https://www.colorado.edu/sccr/honor-code). Violations of the Honor Code may include, but are not limited to: plagiarism, cheating, fabrication, lying, bribery, threat, unauthorized access to academic materials, clicker fraud, submitting the same or similar work in more than one course without permission from all course instructors involved, and aiding academic dishonesty. All incidents of academic misconduct will be reported to Student Conduct & Conflict Resolution ([honor\@colorado.edu](mailto:honor@colorado.edu){.email}); 303-492-5550). Students found responsible for violating the Honor Code will be assigned resolution outcomes from the Student Conduct & Conflict Resolution as well as be subject to academic sanctions from the faculty member. Additional information regarding the Honor Code academic integrity policy can be found on the [Honor Code website](https://www.colorado.edu/sccr/honor-code).


#### Sexual misconduct, discrimination, harassment and/or related retaliation

CU Boulder is committed to fostering an inclusive and welcoming learning, working, and living environment. University policy prohibits sexual misconduct (harassment, exploitation, and assault), intimate partner violence (dating or domestic violence), stalking, protected-class discrimination and harassment, and related retaliation by or against members of our community on- and off-campus. These behaviors harm individuals and our community. The Office of Institutional Equity and Compliance (OIEC) addresses these policies, and individuals who believe they have been subjected to misconduct can contact OIEC at 303-492-2127 or email cureport@colorado.edu. Information about university policies, [reporting options](https://www.colorado.edu/oiec/reporting-resolutions/making-report), and support resources can be found on the [OIEC website](http://www.colorado.edu/institutionalequity/).

Please know that faculty and graduate instructors have a responsibility to inform OIEC when they are made aware of any issues related to these policies regardless of when or where they occurred to ensure that individuals impacted receive information about their rights, support resources, and resolution options. To learn more about reporting and support options for a variety of concerns, visit [Don’t Ignore It](https://www.colorado.edu/dontignoreit/).


#### Religious holidays

Campus policy regarding religious observances requires that faculty make every effort to deal reasonably and fairly with all students who, because of religious obligations, have conflicts with scheduled exams, assignments or required attendance. In this class, in most cases you should have sufficient time to complete the assignments and submit them on time, or early if appropriate. If this does not work for your situation, please notify me at least two weeks in advance of the conflict to request special accommodation. See the [campus policy regarding religious observances](http://www.colorado.edu/policies/observance-religious-holidays-and-absences-classes-andor-exams) for full details.

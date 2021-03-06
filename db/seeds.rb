# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# run-time variables (set these to true if you want seeds to run them):
# 1. create_user_accounts
# 2. delete_page_content
# 3. delete_reform_colors
# 4. delete_test_data
# 5. load_test_data
#
# To load seeds with all variables set to true:
#
# bundle exec rake db:seed create_user_accounts=true delete_page_content=true delete_reform_colors=true delete_test_data=true load_test_data=true

roles = %w(super_admin site_admin content_manager)
roles.each do |role|
  Role.find_or_create_by(name: role)
end

# if this is not production
# and variable is set, create users if not exist
if ENV['create_user_accounts'].present? && !Rails.env.production?
  puts "LOADING TEST USER ACCOUNTS"
  User.find_or_create_by(email: 'site.admin@test.ge') do |u|
    puts "creating site admin"
    u.password = 'password123'
    u.role_id = 2
  end

  User.find_or_create_by(email: 'content.manager@test.ge') do |u|
    puts "creating content manager"
    u.password = 'password123'
    u.role_id = 3
  end
end


if ENV['delete_page_content'].present?
  puts 'DELETING PAGE CONTENT'
  PageContent.destroy_all
end


# load page content records with placeholder text
# home page about
PageContent.find_or_create_by(name: 'home_page_about') do |pc|
    puts 'creating page content for home page about'
    pc.title = 'What are Reforms?'
    pc.content = '<p>Reforms are where changes are made in order to improve something.</p>'
end
# review board methodology
# PageContent.find_or_create_by(name: 'methodology_review_board') do |pc|
#     puts 'creating page content for methodology review board'
#     pc.title = 'Review Board Survey Methodology'
#     pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
# end
# government methodology
PageContent.find_or_create_by(name: 'methodology_government') do |pc|
    puts 'creating page content for methodology government'
    pc.title = 'Government Survey Methodology'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# stakeholder methodolgy
PageContent.find_or_create_by(name: 'methodology_stakeholder') do |pc|
    puts 'creating page content for methodology stakeholder'
    pc.title = 'Stakeholder Survey Methodology'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# about text
PageContent.find_or_create_by(name: 'about_text') do |pc|
    puts 'creating page content for about text'
    pc.title = 'About ReforMeter'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# reform text
PageContent.find_or_create_by(name: 'reform_text') do |pc|
    puts 'creating page content for reform text'
    pc.title = 'What are Reforms?'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# review board text
# PageContent.find_or_create_by(name: 'review_board_text') do |pc|
#     puts 'creating page content for review board text'
#     pc.title = 'Review Board'
#     pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
# end
# download text
PageContent.find_or_create_by(name: 'download_text') do |pc|
    puts 'creating page content for download text'
    pc.title = 'Download Data & Reports'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# download review board text
# PageContent.find_or_create_by(name: 'download_review_board_text') do |pc|
#     puts 'creating page content for download review board text'
#     pc.title = 'Review Board'
#     pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit.</p>'
# end
# download reform text
PageContent.find_or_create_by(name: 'download_reform_text') do |pc|
    puts 'creating page content for download reform text'
    pc.title = 'Reforms'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit.</p>'
end
# download ext ind text
PageContent.find_or_create_by(name: 'download_external_indicator_text') do |pc|
    puts 'creating page content for download external indicators text'
    pc.title = 'External Indicators'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit.</p>'
end
# download reports text
PageContent.find_or_create_by(name: 'download_report_text') do |pc|
    puts 'creating page content for download report text'
    pc.title = 'Reports'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit.</p>'
end
# contact intro text
PageContent.find_or_create_by(name: 'contact_text') do |pc|
    puts 'creating page content for contact text'
    pc.title = 'Contact'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit.</p>'
end
# general methodology
PageContent.find_or_create_by(name: 'methodology_general') do |pc|
    puts 'creating page content for general methodology'
    pc.title = 'Methodology'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# reform outcome
PageContent.find_or_create_by(name: 'outcome') do |pc|
    puts 'creating page content for reform outcome'
    pc.title = 'Outcome'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end
# reformverdict
PageContent.find_or_create_by(name: 'verdict') do |pc|
    puts 'creating page content for verdict'
    pc.title = 'ReformVerdict'
    pc.content = '<p>Lorem ipsum dolor sit amet, te duo probo timeam salutandi, iriure nostrud periculis et sit. Cu nostro alienum per, et usu porro inermis civibus, ad mei porro ceteros voluptatibus.</p> <p>Ferri commune voluptatibus ne sed. Id sea labitur liberavisse voluptatibus. Populo consetetur repudiandae ad nam. Regione complectitur mel ea, in veri eripuit vix. Ius idque impedit periculis at. Ex sea tota vidit prima, adhuc accusamus cu eam. Iuvaret fabellas ea vel, ne eum mundi incorrupte dissentiunt. Congue ridens temporibus at eam.</p>'
end

# disclaimer
PageContent.find_or_create_by(name: 'disclaimer') do |pc|
    puts 'creating page content for disclaimer'
    pc.title = 'Disclaimer'
    pc.content_en = '<p>This application is made possible by the support of the American People through the United States Agency for International Development (USAID). The contents of this application are the responsibility of International School of Economics at Tbilisi State University (ISET) Policy Institute and do not necessarily reflect the views of USAID or the United States Government.</p>'
    pc.content_ka = '<p>ამ კომპიუტერული პროგრამის შექმნა შესაძლებელი გახდა ამერიკელი ხალხის მიერ ამერიკის შეერთებული შტატების საერთაშორისო განვითარების სააგენტოს (USAID)  მეშვეობით გაწეული დახმარების შედეგად. მის შინაარსზე  პასუხისმგებელია თბილისის სახელმწიფო უნივერსიტეტის ეკონომიკის საერთაშორისო სკოლის კვლევითი ინსტიტუტი (ISET Policy Institute) და შეიძლება არ ემთხვეოდეს USAID-ის ან ამერიკის შეერთებული შტატების მთავრობის პოზიციას.</p>'
end




if ENV['delete_reform_colors'].present?
  puts 'DELETING REFORM COLORS'
  ReformColor.destroy_all
end

# load reform colors
colors = %w{#4dc1bb #2bb673 #e0689e #7668dd #8dabd8 #6ab1d8 #9fd66b #d6c654 #fbb040 #db9f4f #d86a50 #e84646 #5dcec8 #b464bf}
rc_colors = []
colors.each do |color|
  rc_colors << ReformColor.find_or_create_by(hex: color) do |rc|
    puts 'creating reform color: ' + color
    rc.hex = color
  end
end

if ENV['delete_test_data'].present? || ENV['load_test_data'].present?
  # first clear all data
  puts 'deleting data in database (quarter, reform, experts, survey data, etc)'
  Reform.destroy_all
  Expert.destroy_all
  ExternalIndicator.destroy_all
  News.destroy_all
  Report.destroy_all
  Verdict.destroy_all
end


# if the env variable of load_test_data exists, load the data
if ENV['load_test_data'].present?
  path = "#{Rails.root}/db/test_report_files/"
  img_path = "#{Rails.root}/db/test_image_files/"

  puts 'LOADING TEST DATA'

  # create reform
  puts 'creating test reform'
  reform1 = Reform.create(name_en: 'Small and Medium Enterprises', name_ka: 'მცირე და საშუალო ბიზნესი', summary: 'This is a brief summary about the small and medium enterprises reform.', reform_color_id: rc_colors.delete_at(rand(rc_colors.length)).id)
  reform2 = Reform.create(name_en: 'Insolvency System', name_ka: 'გადახდისუუნარობის სისტემა', summary: 'This is a brief summary about the insolvency system reform.', reform_color_id: rc_colors.delete_at(rand(rc_colors.length)).id)
  reform3 = Reform.create(name_en: 'Innovations', name_ka: 'ინოვაციები', summary: 'This is a brief summary about the innovations reform.', reform_color_id: rc_colors.delete_at(rand(rc_colors.length)).id)
  reform4 = Reform.create(name_en: 'Pension System', name_ka: 'საპენსიო სისტემა', summary: 'This is the pension system reform.', reform_color_id: rc_colors.delete_at(rand(rc_colors.length)).id)
  reform5 = Reform.create(name_en: 'Land Registration', name_ka: 'მიწის რეგისტრაცია', summary: 'This is the land registration reform.', reform_color_id: rc_colors.delete_at(rand(rc_colors.length)).id)

  # create members
  puts 'creating members'
  exp1 = Expert.create(name: 'Giorgi Gamkharashvili', bio: 'Giorgi Gamkharashvili is cool cat from Sesame Street.', expert_type: Expert::EXPERT_TYPES[:steering_committee])
  exp2 = Expert.create(name: 'Mariam Macharashvili', bio: 'Mariam Macharashvili doesn\'t know how to get to Sesame Street.', expert_type: Expert::EXPERT_TYPES[:steering_committee])
  exp3 = Expert.create(name: 'Irakli Sultanishvili', bio: 'Irakli Sultanishvili was born and raised on Sesame Street.', expert_type: Expert::EXPERT_TYPES[:executive_team])
  exp4 = Expert.create(name: 'Mariam Gamkharashvili', bio: 'Mariam Gamkharashvili is cool cat from Sesame Street.', expert_type: Expert::EXPERT_TYPES[:executive_team])
  exp5 = Expert.create(name: 'Irakli Macharashvili', bio: 'Irakli Macharashvili doesn\'t know how to get to Sesame Street.', expert_type: Expert::EXPERT_TYPES[:stakeholder], reform_id: reform1.id)
  exp6 = Expert.create(name: 'Giorgi Gamkharashvili', bio: 'Giorgi Gamkharashvili was born and raised on Sesame Street.', expert_type: Expert::EXPERT_TYPES[:stakeholder], reform_id: reform1.id)
  exp7 = Expert.create(name: 'Mariam Sultanishvili', bio: 'Mariam Sultanishvili doesn\'t know how to get to Sesame Street.', expert_type: Expert::EXPERT_TYPES[:stakeholder], reform_id: reform2.id)

  # create reports
  report_en = File.open(path + 'sample_report1.pdf')
  report_ka = File.open(path + 'sample_report2.pdf')
  Report.create(title_en: '2016 Phase 2', title_ka: '2016 Phase 2', report_en: report_ka, report_ka: report_en, report_date: '2017-01-01')
  Report.create(title_en: '2017 Phase 1', title_ka: '2017 Phase 1',report_en: report_en, report_ka: report_ka, report_date: '2017-07-01')


  # create verdicts
  puts 'creating verdicts'
  v1 = Verdict.create(overall_score: 6.4, category1_score: 6, category2_score: 8, category3_score: 5,
                              title_en: '2016 Phase 1', title_ka: '2016 Phase 1',
                              summary_en: 'this is a verdict summary',
                              summary_ka: 'this is a verdict summary',
                              is_public: true, time_period: '2016-06-30')
  v2 = Verdict.create(overall_score: 5.36, category1_score: 5.8, category2_score: 6, category3_score: 4.5,
                              title_en: '2016 Phase 2', title_ka: '2016 Phase 2',
                              summary_en: 'this is a verdict summary',
                              summary_ka: 'this is a verdict summary',
                              is_public: true, time_period: '2016-12-31')

  v1.news.create(title: 'This is verdict news', content: "this is verdict news for #{v1.time_period}", url: 'http://google.ge')
  v1.news.create(title: 'This is more verdict news', content: 'this is additional news for #{v1.time_period} with image!', url: 'http://google.ge', image: File.new(img_path + '1.jpg'))
  v2.news.create(title: 'This is verdict news', content: "this is verdict news for #{v2.time_period}", url: 'http://google.ge')

  # create reform surveys
  puts 'creating reform surveys'
  reform_survey_scores = [
    [
      [63.5, 70, 35, 62, 80, 5.6,6,6.8,4.2],
      [65, 72, 38, 63, 80, 5.36, 5.8, 6, 4.5],
      [66.9, 73, 41, 65, 82, 6.82, 6.5, 8.3, 5.5],
    ],
    [
      [23.5, 30, 35, 62, 80, 5.6,6,6.8,4.2],
      [35, 42, 38, 63, 80, 6.82, 6.5, 8.3, 5.5],
      [46.9, 53, 41, 65, 82, 5.36, 5.8, 6, 4.5],
    ],
    [
      [63, 50, 35, 62, 80, 6.82, 6.5, 8.3, 5.5],
      [63, 52, 58, 63, 80, 5.36, 5.8, 6, 4.5],
      [63, 73, 71, 63, 82, 5.6,6,6.8,4.2],
    ],
    [
      [33.5, 30, 35, 62, 80, 5.6,6,6.8,4.2],
      [35, 42, 38, 63, 80, 5.36, 5.8, 6, 4.5],
      [35, 53, 41, 65, 82, 6.82, 6.5, 8.3, 5.5],
    ]
  ]

  (0..3).each do |index|
    id = index == 0 ? reform1.id : index == 1  ? reform2.id : index == 2 ? reform3.id : reform4.id
#    score_indexes = index == 0 ? [0,1,2] : index == 1  ? [1,2,0] : index == 2 ? [2,1,0] : [2, 0, 1]
    rs2, rs3, rs4 = nil
    # do not create value for 3rd reform in q2
    if index != 2
      rs2 = ReformSurvey.create(reform_id: id, time_period: "2016-04-01", is_public: true, quarter_id: 1, verdict_id: v1.id,
              government_overall_score: reform_survey_scores[index][0][0],government_category1_score: reform_survey_scores[index][0][1],
              government_category2_score: reform_survey_scores[index][0][2],government_category3_score: reform_survey_scores[index][0][3],
              government_category4_score: reform_survey_scores[index][0][4], stakeholder_overall_score: reform_survey_scores[index][0][5],
              stakeholder_category1_score: reform_survey_scores[index][0][6],stakeholder_category2_score: reform_survey_scores[index][0][7],
              stakeholder_category3_score: reform_survey_scores[index][0][8],
              summary: 'this is a summary', government_summary: '<p>this is a government summary</p>', stakeholder_summary: '<p>this is a stakeholder summary</p>',
              report_en: report_en, report_ka: report_ka)

      rs2.news.create(reform_id: id, title: 'This is reform news', content: "this is reform news for #{rs2.time_period}", url: 'http://google.ge')
      rs2.news.create(reform_id: id, title: 'This is more reform news', content: 'this is additional news for #{rs2.time_period} with image!', url: 'http://google.ge', image: File.new(img_path + '1.jpg'))

    end

    if index != 3
      rs3 = ReformSurvey.create(reform_id: id, time_period: "2016-07-01", is_public: true, quarter_id: 1, verdict_id: v2.id,
              government_overall_score: reform_survey_scores[index][1][0],government_category1_score: reform_survey_scores[index][1][1],
              government_category2_score: reform_survey_scores[index][1][2],government_category3_score: reform_survey_scores[index][1][3],
              government_category4_score: reform_survey_scores[index][1][4], stakeholder_overall_score: reform_survey_scores[index][1][5],
              stakeholder_category1_score: reform_survey_scores[index][1][6],stakeholder_category2_score: reform_survey_scores[index][1][7],
              stakeholder_category3_score: reform_survey_scores[index][1][8],
              summary: 'this is a summary', government_summary: '<p>this is a government summary</p>', stakeholder_summary: '<p>this is a stakeholder summary</p>',
              report_en: report_en, report_ka: report_ka)

      # rs4 = ReformSurvey.create(reform_id: id, time_period: "2016-10-01", is_public: true, quarter_id: 1, verdict_id: v2.id,
      #         government_overall_score: reform_survey_scores[index][2][0],government_category1_score: reform_survey_scores[index][2][1],
      #         government_category2_score: reform_survey_scores[index][2][2],government_category3_score: reform_survey_scores[index][2][3],
      #         government_category4_score: reform_survey_scores[index][2][4], stakeholder_overall_score: reform_survey_scores[index][2][5],
      #         stakeholder_category1_score: reform_survey_scores[index][2][6],stakeholder_category2_score: reform_survey_scores[index][2][7],
      #         stakeholder_category3_score: reform_survey_scores[index][2][8],
      #         summary: 'this is a summary', government_summary: '<p>this is a government summary</p>', stakeholder_summary: '<p>this is a stakeholder summary</p>')
    end

  end


  # external indicators
  csv_path = "#{Rails.root}/db/test_external_indicator_files/"
  puts 'creating external indicators'

  ei = ExternalIndicator.new(title: 'Growth of Total Factor Productivity', scale_type: 2, indicator_type: 2, chart_type: 2, is_public: true, description: 'This is the external indicator for the growth of total factor productivity.',
                              benchmark_title_en: 'EU Average', benchmark_title_ka: 'EU Average', has_benchmark: true)
  csv_data = CSV.read(csv_path + 'growth.csv')

  # countries
  csv_data[0].each_with_index do |header, index|
    if index > 0
      # if this is the last header, do not record because it is benchmark
      if index < csv_data[0].length-1
        ei.countries.build(name: header, sort_order: index)
      end
    end
  end

  # times
  csv_data.map{|x| x[0]}.each_with_index do |time, index|
    if index > 0
      ei.time_periods.build(name: time, sort_order: index)
    end
  end
  ei.save

  #data
  csv_data.each_with_index do |row, r_index|
    if r_index > 0
      time = ei.time_periods[r_index-1]

      row.each_with_index do |cell, c_index|
        if c_index > 0
          is_benchmark = row.length-1 == c_index && ei.has_benchmark?
          time.data.build(
            country_id: is_benchmark ? nil : ei.countries[c_index-1].id,
            value: row[c_index],
            is_benchmark: is_benchmark
          )
        end
      end
    end
  end
  ei.update_change_values = true
  ei.save
  ei.reforms << reform1


  ei = ExternalIndicator.new(title: 'How do people feel about the economy?', subtitle: 'Georgian Economic Sentiment Index (G-ESI)', description: 'A confidence index of +100 would indicate that economic agents (consumers and businesses) were much more confident about future prospects, while -100 would indicate that all survey respondents were much less confident about future prospects.', scale_type: 2, indicator_type: 3, chart_type: 2, min: -100, max: 100, show_on_home_page: true, sort_order: 2, is_public: true, use_decimals: true,
                              benchmark_title_en: 'Benchmark', benchmark_title_ka: 'Benchmark', has_benchmark: true)
  csv_data = CSV.read(csv_path + 'gesi.csv')

  # indices
  ei.indices.build(name: 'Business Confidence Index', short_name: 'BCI', sort_order: 1)
  ei.indices.build(name: 'Consumer Confidence Index', short_name: 'CCI', sort_order: 2)

  # plot bands
  ei.plot_bands.build(name_en: 'Negative', name_ka: 'უარყოფითი', from: -100, to: -33)
  ei.plot_bands.build(name_en: 'Neutral', name_ka: 'საშუალო', from: -33, to: 33)
  ei.plot_bands.build(name_en: 'Positive', name_ka: 'დადებითი', from: 33, to: 100)

  # times
  csv_data.map{|x| x[0]}.each_with_index do |time, index|
    if index > 0
      ei.time_periods.build(name: time, sort_order: index)
    end
  end
  ei.save

  #data
  csv_data.each_with_index do |row, r_index|
    if r_index > 0
      time = ei.time_periods[r_index-1]

      row.each_with_index do |cell, c_index|
        if c_index > 0
          if c_index == 1
            time.overall_value = row[c_index]
          else
            is_benchmark = row.length-1 == c_index && ei.has_benchmark?
            time.data.build(
              index_id: is_benchmark ? nil : ei.indices[c_index-2].id,
              value: row[c_index],
              is_benchmark: is_benchmark
            )
          end
        end
      end
    end
  end
  ei.update_change_values = true
  ei.save
  ei.reforms << reform2


  ei = ExternalIndicator.new(title: 'How is the economy doing?', subtitle: 'Georgian Economic Performance Index (G-EPI)', scale_type: 2, indicator_type: 3, chart_type: 1, min: 0, max: 100, show_on_home_page: true, sort_order: 1, is_public: true, use_decimals: true)
  csv_data = CSV.read(csv_path + 'gepi.csv')

  # indices
  ei.indices.build(name: 'Difference in borrowing and lending rates of financial institutions', short_name: 'Net Interest Spread', change_multiplier: -1, sort_order: 1)
  ei.indices.build(name: 'Georgia’s performance in the OECD Programme for International Student Assessment (Pisa)', short_name: 'Pisa', change_multiplier: 1, sort_order: 2)
  ei.indices.build(name: 'Waste water treatment capacity per capita', short_name: 'Waste water treatment capacity per capita', change_multiplier: 1, sort_order: 3)
  ei.indices.build(name: 'The change in real GDP', short_name: '%∆GDP', change_multiplier: 1, sort_order: 4)
  ei.indices.build(name: 'Dollarization rate of the Georgian economy', short_name: 'Dollarization Rate', change_multiplier: -1, sort_order: 5)
  ei.indices.build(name: 'Share of investment in total GDP ', short_name: 'Investment % of GDP', change_multiplier: 1, sort_order: 6)
  ei.indices.build(name: 'Degree of export diversification across major geographic jurisdictions', short_name: 'Export Diversification', change_multiplier: 1, sort_order: 7)
  ei.indices.build(name: 'Degree of export innovation (measured as the share of new products and services in total exports)', short_name: 'Creative Export', change_multiplier: 1, sort_order: 8)
  ei.indices.build(name: 'Share of formally employed in Georgia’s total population', short_name: 'Formal Employment', change_multiplier: 1, sort_order: 9)
  ei.indices.build(name: 'Gini coefficient as measure of income inequality', short_name: 'Gini', change_multiplier: -1, sort_order: 10)

  # plot bands
  ei.plot_bands.build(name_en: 'Poor', name_ka: 'ცუდი', from: 0, to: 33)
  ei.plot_bands.build(name_en: 'Fair', name_ka: 'საშუალო', from: 34, to: 66)
  ei.plot_bands.build(name_en: 'Good', name_ka: 'კარგი', from: 67, to: 100)

  # times
  csv_data.map{|x| x[0]}.each_with_index do |time, index|
    if index > 0
      ei.time_periods.build(name: time, sort_order: index)
    end
  end
  ei.save

  #data
  csv_data.each_with_index do |row, r_index|
    if r_index > 0
      time = ei.time_periods[r_index-1]

      row.each_with_index do |cell, c_index|
        if c_index > 0
          if c_index == 1
            time.overall_value = row[c_index]
          else
            time.data.build(index_id: ei.indices[c_index-2].id, value: row[c_index])
          end
        end
      end
    end
  end
  ei.update_change_values = true
  ei.save



  ei = ExternalIndicator.new(title: 'Georgia Growth of Total Factor Productivity', scale_type: 2, indicator_type: 1, chart_type: 1, is_public: true,
                              benchmark_title_en: 'EU Average', benchmark_title_ka: 'EU Average', has_benchmark: true)
  csv_data = CSV.read(csv_path + 'geo_growth.csv')

  # times
  csv_data.map{|x| x[0]}.each_with_index do |time, index|
    if index > 0
      ei.time_periods.build(name: time, sort_order: index)
    end
  end
  ei.save

  #data
  csv_data.each_with_index do |row, r_index|
    if r_index > 0
      time = ei.time_periods[r_index-1]

      row.each_with_index do |cell, c_index|
        if c_index > 0
          is_benchmark = row.length-1 == c_index && ei.has_benchmark?
          time.data.build(
            value: row[c_index],
            is_benchmark: is_benchmark
          )
        end
      end
    end
  end
  ei.update_change_values = true
  ei.save
  ei.reforms << reform1
  ei.reforms << reform2
  ei.reforms << reform3


  ei = ExternalIndicator.new(title: 'Line Chart Total Factor Productivity', subtitle: 'This is the very loooooong subtitle of Line Chart Total Factor Productivity', scale_type: 2, indicator_type: 2, chart_type: 1, is_public: true,
                              benchmark_title_en: 'EU Average', benchmark_title_ka: 'EU Average', has_benchmark: true)
  csv_data = CSV.read(csv_path + 'growth.csv')

  # countries
  csv_data[0].each_with_index do |header, index|
    if index > 0
      # if this is the last header, do not record because it is benchmark
      if index < csv_data[0].length-1
        ei.countries.build(name: header, sort_order: index)
      end
    end
  end

  # times
  csv_data.map{|x| x[0]}.each_with_index do |time, index|
    if index > 0
      ei.time_periods.build(name: time, sort_order: index)
    end
  end
  ei.save

  #data
  csv_data.each_with_index do |row, r_index|
    if r_index > 0
      time = ei.time_periods[r_index-1]

      row.each_with_index do |cell, c_index|
        if c_index > 0
          is_benchmark = row.length-1 == c_index && ei.has_benchmark?
          time.data.build(
            country_id: is_benchmark ? nil : ei.countries[c_index-1].id,
            value: row[c_index],
            is_benchmark: is_benchmark
          )
        end
      end
    end
  end
  ei.update_change_values = true
  ei.save
  ei.reforms << reform1

  puts 'LOADING TEST DATA DONE'
end

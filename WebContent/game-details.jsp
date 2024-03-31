<%@page import="java.util.ArrayList"%>
<%@ page import="com.hp.hpl.jena.query.Query,
 com.hp.hpl.jena.query.QueryExecution,
com.hp.hpl.jena.query.QueryExecutionFactory,
com.hp.hpl.jena.query.QueryFactory,
com.hp.hpl.jena.query.QuerySolution,
com.hp.hpl.jena.query.ResultSet,
com.hp.hpl.jena.rdf.model.*,
com.hp.hpl.jena.reasoner.Reasoner,
com.hp.hpl.jena.reasoner.ReasonerRegistry,
com.hp.hpl.jena.reasoner.ValidityReport,
com.hp.hpl.jena.reasoner.rulesys.GenericRuleReasoner,
com.hp.hpl.jena.reasoner.rulesys.Rule,
com.hp.hpl.jena.util.FileManager,
java.io.IOException,
java.io.InputStream,
java.util.Iterator,
java.util.ArrayList,
java.util.List,
java.net.URLDecoder" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <title>Lugx Gaming - Game Details</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-lugx-gaming.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    <link rel="stylesheet" href="assets/css/animate.css">
<!--

TemplateMo 589 lugx gaming

https://templatemo.com/tm-589-lugx-gaming

-->
 <style>
        .rating {
            font-size: 50px; /* Adjust the font size as needed */
            color: gold;
        }
        .best-seller-badge {
            background-color: #ffcc00;
            color: #333;
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: bold;
            position: absolute;
            top: 10px; /* Adjust the distance from the top */
            left: 10px; /* Adjust the distance from the left */
            z-index: 2; /* Ensure the badge is above the stars */
        }
    </style>
  </head>

<body>
<%
	String gameName = request.getParameter("gameName");
    gameName = URLDecoder.decode(gameName, "UTF-8");
    //gameName = gameName.replaceAll("%20", "_");
%>
<%!
static String defaultNameSpace = "http://www.owl-ontologies.com/Ontology1702814107.owl#";

public Model Mod = null;

String game_name ,  game_genre,  game_req , game_image , game_desc, game_rating, game_store, game_language, game_platform, game_category, game_size, game_stype;
ArrayList<String> genre_list = new ArrayList<String>();
ArrayList<String> store_list = new ArrayList<String>();
ArrayList<String> platform_list = new ArrayList<String>();
ArrayList<String> language_list = new ArrayList<String>();


// Query 2
ArrayList<String> game_list = new ArrayList<String>();
ArrayList<String> image_list = new ArrayList<String>();
ArrayList<String> name_list = new ArrayList<String>();

int count =0;

%>

<%!
public void LoadOntology(){
	Mod = ModelFactory.createOntologyModel();
	 InputStream inFoafInstance1 = FileManager.get().open("Ontologies/game2.owl");
	Mod.read(inFoafInstance1,defaultNameSpace);
}
%>

<%!
public void runQuery( String queryRequest , Model model){

StringBuffer queryStr=new StringBuffer();
//Establish Prefixes 

		queryStr.append("PREFIX game" + ": <" + defaultNameSpace + "> ");
		queryStr.append("PREFIX rdfs" + ": <" + "http://www.w3.org/2000/01/rdf-schema#" + "> ");
		queryStr.append("PREFIX rdf" + ": <" + "http://www.w3.org/1999/02/22-rdf-syntax-ns#" + "> ");
		queryStr.append("PREFIX sqwrl" + ": <" + "http://sqwrl.stanford.edu/ontologies/built-ins/3.4/sqwrl.owl#" + "> ");
		queryStr.append("PREFIX owl" + ": <" + "http://www.w3.com/2002/07/owl#" + "> ");
		queryStr.append("PREFIX swrl" + ": <" + "http://www.w3.com/2003/11/swrl#" + "> ");
		queryStr.append("PREFIX swrla" + ": <" + "http://swrl.stanford.edu/ontologies/3.3/swrla.owl#" + "> ");
		queryStr.append("PREFIX swrlb" + ": <" + "http://www.w3.com/2003/11/swrlb#" + "> ");
		queryStr.append("PREFIX xsd" + ": <" + "http://www.w3.com/2001/XMLSchema" + "> ");
		queryStr.append("PREFIX xsp" + ": <" + "http://www.owl-ontologies.com/2005/08/07/xsp.owl#" + "> ");
		queryStr.append("PREFIX protege" + ": <" + "http://protege.stanford.edu/plugins/owl/protege#" + "> ");


//New add query
queryStr.append(queryRequest);
Query query =QueryFactory.create(queryStr.toString());
QueryExecution qexec = QueryExecutionFactory.create(query,model);

try{
	
	ResultSet respone=qexec.execSelect();
	count=0;
	while(respone.hasNext()){
		
		QuerySolution soln=respone.nextSolution();
		RDFNode name = soln.get("?name");
		RDFNode genre = soln.get("?genre");
		RDFNode img   = soln.get("?image");
		RDFNode description = soln.get("?desc");
		RDFNode store = soln.get("?store");
		RDFNode language = soln.get("?language");
		RDFNode platform = soln.get("?platform");
		RDFNode rating = soln.get("?rating");
		RDFNode category = soln.get("?category");
		RDFNode size = soln.get("?size");
		RDFNode size_type = soln.get("?stype");
		//RDFNode publisher = soln.get("?publisher");
		
		if(genre != null || img != null){
			
		
			// set name
			game_name= name.toString();
			game_name=game_name.substring(0,game_name.indexOf('@'));                   //price
			
			// set genre
			game_genre= genre.toString();
			game_genre=game_genre.substring(53,game_genre.length());
			genre_list.add(count, game_genre);
			
			// set image
			game_image = img.toString();
			game_image = game_image.substring(0,game_image.indexOf('@'));
			
			
			// set Description
			game_desc = description.toString();
			game_desc = game_desc.substring(0,game_desc.indexOf('@'));
			
			// set Stores
			game_store= store.toString();
			game_store=game_store.substring(53,game_store.length());
			store_list.add(count, game_store);
			
			// set Languages
			game_language= language.toString();
			game_language=game_language.substring(53, game_language.length());
			language_list.add(count, game_language);
			
			// set Platforms
			game_platform= platform.toString();
			game_platform=game_platform.substring(53,game_platform.length());
			platform_list.add(count, game_platform);
			
			// set Rating
			game_rating= rating.toString();
			game_rating = game_rating.substring(0,game_rating.indexOf('^'));
			
			// set category
			game_category = category.toString();
			game_category=game_category.substring(53,game_category.length());
			
			
			// set size
			game_size= size.toString();
			game_size = game_size.substring(0,game_size.indexOf('^'));
			
			// set size type
			game_stype = size_type.toString();
			game_stype = game_stype.substring(0, game_stype.indexOf('^'));
			
			// set publisher
			//game_publisher = publisher.toString();
			//game_publisher = game_publisher.substring(53,game_publisher.length());
			
			count++;   // increament counter
			
		}
		else 
			System.out.println("No Result Found !!");
	}
  }

  finally{qexec.close();}
}
%>

<%!
public void runQuery2( String queryRequest , Model model){

StringBuffer queryStr=new StringBuffer();
//Establish Prefixes 

		queryStr.append("PREFIX game" + ": <" + defaultNameSpace + "> ");
		queryStr.append("PREFIX rdfs" + ": <" + "http://www.w3.org/2000/01/rdf-schema#" + "> ");
		queryStr.append("PREFIX rdf" + ": <" + "http://www.w3.org/1999/02/22-rdf-syntax-ns#" + "> ");
		queryStr.append("PREFIX sqwrl" + ": <" + "http://sqwrl.stanford.edu/ontologies/built-ins/3.4/sqwrl.owl#" + "> ");
		queryStr.append("PREFIX owl" + ": <" + "http://www.w3.com/2002/07/owl#" + "> ");
		queryStr.append("PREFIX swrl" + ": <" + "http://www.w3.com/2003/11/swrl#" + "> ");
		queryStr.append("PREFIX swrla" + ": <" + "http://swrl.stanford.edu/ontologies/3.3/swrla.owl#" + "> ");
		queryStr.append("PREFIX swrlb" + ": <" + "http://www.w3.com/2003/11/swrlb#" + "> ");
		queryStr.append("PREFIX xsd" + ": <" + "http://www.w3.com/2001/XMLSchema" + "> ");
		queryStr.append("PREFIX xsp" + ": <" + "http://www.owl-ontologies.com/2005/08/07/xsp.owl#" + "> ");
		queryStr.append("PREFIX protege" + ": <" + "http://protege.stanford.edu/plugins/owl/protege#" + "> ");


//New add query
queryStr.append(queryRequest);
Query query =QueryFactory.create(queryStr.toString());
QueryExecution qexec = QueryExecutionFactory.create(query,model);

try{
	
	ResultSet respone=qexec.execSelect();
	count=0;
	while(respone.hasNext()){
		
		QuerySolution soln=respone.nextSolution();
		RDFNode name = soln.get("?name");
		RDFNode img   = soln.get("?image");
		RDFNode game = soln.get("?game");
		
		if(img != null || game != null){
			
		
						// set name
						game_name= name.toString();
						game_name=game_name.substring(0,game_name.indexOf('@'));                   //price
						name_list.add(count, game_name);
						
						
						// set image
						game_image = img.toString();
						game_image = game_image.substring(0,game_image.indexOf('@'));
						image_list.add(count, game_image);
						
						
						game_req= game.toString();
						game_req=game_req.substring(53,game_req.length());
						game_list.add(count, game_req);
			
			count++;   // increament counter
			
		}
		else 
			System.out.println("No Result Found !!");
	}
  }

  finally{qexec.close();}
}
%>
  <!-- ***** Preloader Start ***** -->
  <div id="js-preloader" class="js-preloader">
    <div class="preloader-inner">
      <span class="dot"></span>
      <div class="dots">
        <span></span>
        <span></span>
        <span></span>
      </div>
    </div>
  </div>
  <!-- ***** Preloader End ***** -->

  <!-- ***** Header Area Start ***** -->
  <header class="header-area header-sticky">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <nav class="main-nav">
                    <!-- ***** Logo Start ***** -->
                    <a href="Index.jsp" class="logo">
                        <img src="assets/images/logo.png" alt="" style="width: 158px;">
                    </a>
                    <!-- ***** Logo End ***** -->
                    <!-- ***** Menu Start ***** -->
                    <ul class="nav">
                      <li><a href="Index.jsp">Home</a></li>
                      <li><a href="games.jsp">Games</a></li>
                  </ul>   
                    <a class='menu-trigger'>
                        <span>Menu</span>
                    </a>
                    <!-- ***** Menu End ***** -->
                </nav>
            </div>
        </div>
    </div>
  </header>
  <!-- ***** Header Area End ***** -->
<%
LoadOntology();
//Query
runQuery("SELECT ?name ?genre ?rating ?desc ?store ?language ?platform ?image ?category ?size ?stype Where { game:" + gameName + " game:game_name ?name. game:" + gameName + " game:IsGenreOf ?genre. game:" + gameName + " game:Critic_Rating ?rating. game:" + gameName + " game:description ?desc. game:" + gameName + " game:hasSameStore ?store. game:" + gameName + " game:hasLanguage ?language. game:" + gameName + " game:image ?image. game:" + gameName + " game:hasPlatform ?platform. game:" + gameName + " game:hasCategory ?category. game:" + gameName + " game:size ?size. game:"  + gameName +  " game:gb ?stype. FILTER (?size > 0)}", Mod);
%>
  <div class="page-heading header-text">
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <h3><%= game_name %></h3>
          <span class="breadcrumb"><a href="Index.jsp">Home</a>  >  <a href="games.jsp">Games</a>  >  <%= game_name %></span>
        </div>
      </div>
    </div>
  </div>
  <div class="single-product section">
    <div class="container">
      <div class="row">
        <div class="col-lg-6">
          <div class="left-image">
            <a href="game-details.jsp"><img src="<%= "assets" + "/" + (game_image.contains(".jpg") ? game_image : game_image + ".jpg") %>" alt="<%= gameName %>"></a>
          </div>
        </div>
        <div class="col-lg-6 align-self-center">
          <h4><%= game_name %></h4>
          <p><%= game_desc %></p>
          <form id="qty" action="#">
            <button type="submit"><i class="fa fa-download"></i> Download</button>
          </form>
          <ul>
            <li><span>Game ID:</span> #<%= game_name.replaceAll(" ", "_") %></li>
            <li><span>Platforms:</span> <a href="#"><% List<String> processedPlatforms = new ArrayList<>(); for(int e=0;e<count;e++){ String currentPlatform = platform_list.get(e); if (!processedPlatforms.contains(currentPlatform)) {processedPlatforms.add(currentPlatform); out.println(currentPlatform + "<span></span>");}}%></a></li>
            <li><span>Genre:</span> <a href="#"><% List<String> processedGenres = new ArrayList<>(); for(int e=0;e<count;e++){ String currentGenre = genre_list.get(e); if (!processedGenres.contains(currentGenre)) {processedGenres.add(currentGenre); out.println(currentGenre + "<span></span>");}}%></a></li>
            <li><span>Languages:</span> <a href="#"><% List<String> processedLanguages = new ArrayList<>(); for(int e=0;e<count;e++){ String currentLanguage = language_list.get(e); if (!processedLanguages.contains(currentLanguage)) {processedLanguages.add(currentLanguage); out.println(currentLanguage +"<span></span>");}}%></a></li>
            <li><span>Stores:</span> <a href="#"><% List<String> processedStores = new ArrayList<>(); for(int e=0;e<count;e++){ String currentStore = store_list.get(e); if (!processedStores.contains(currentStore)) {processedStores.add(currentStore); out.println(currentStore + "<span></span>");}}%></a></li>
          	<li><span>Category:</span> <%= game_category %></li>
          	<li><span>Size:</span><%= game_size %> <%= (game_stype.equals("true") ? "GB" : "MB") %></li>
          </ul>
        </div>
        <div class="col-lg-12">
          <div class="sep"></div>
        </div>
      </div>
    </div>
  </div>

  <div class="more-info">
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <div class="tabs-content">
            <div class="row">
              <div class="nav-wrapper ">
                <ul class="nav nav-tabs" role="tablist">
                  <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="description-tab" data-bs-toggle="tab" data-bs-target="#description" type="button" role="tab" aria-controls="description" aria-selected="true">Description</button>
                  </li>
                  <li class="nav-item" role="presentation">
                    <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews" type="button" role="tab" aria-controls="reviews" aria-selected="false">Rating <span>(<%= game_rating %>)</span></button>
                  </li>
                </ul>
              </div>              
              <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="description" role="tabpanel" aria-labelledby="description-tab">
                  <%= game_desc %>
                </div>
                <div class="tab-pane fade" id="reviews" role="tabpanel" aria-labelledby="reviews-tab">
 					<p><% out.print("<div class=\"rating\">"); for (int i = 1; i <= 10; i++) { if (i <= Integer.parseInt(game_rating)) { out.print("&#9733;");} else { out.print("&#9734;");}} out.print("</div>"); %></p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
 
    <div class="section most-played">
    <div class="container">
      <div class="row">
        <div class="col-lg-4">
          <div class="section-heading">
          <% int calc = count > 0 ? (count-1) : 0 ; %>
            <h6>Related Games to <span style="color: crimson;text-shadow:2px 2px 10px gray;font-size:25px;"><%= game_name %></span></h6>
            <h2>According to genre of <span style="color: gold;text-shadow:2px 2px 10px gray;font-size:60px;"><%= genre_list.get(calc) %></span></h2>
          </div>
        </div>
        
<%
LoadOntology();
//Query
runQuery2("SELECT DISTINCT ?game ?name ?image WHERE { ?game game:game_name ?name. ?game game:IsGenreOf game:" + genre_list.get(calc) + ". ?game game:image ?image. FILTER (?game != game:"+ gameName + ") } LIMIT 4", Mod);
%>
        
  <%
        for(int e=0 ; e<count ; e++){
            %>
            <div class="col-lg-2 col-md-6 col-sm-8">
          <div class="item">
            <div class="thumb">
             <a href="game-details.jsp"><img src="<%= "assets" + "/" + (image_list.get(e).contains(".jpg") ? image_list.get(e) : image_list.get(e) + ".jpg") %>" alt="<%= image_list.get(e) %>"></a>
            </div>
            <div class="down-content">
              <h4><%= name_list.get(e) %></h4>
                <a href="<%= "game-details.jsp" + "?gameName=" + game_list.get(e) %>">Explore</a>
            </div>
          </div>
        </div>
        <%
        }
        %> 
      
      </div>
    </div>
  </div>
  
  
  
  
  
  
  
  
  
  
  

  <footer>
    <div class="container">
      <div class="col-lg-12">
        <p>Copyright © 2048 LUGX Gaming Company. All rights reserved. &nbsp;&nbsp;</p>
      </div>
    </div>
  </footer>

  <!-- Scripts -->
  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
  <script src="assets/js/isotope.min.js"></script>
  <script src="assets/js/owl-carousel.js"></script>
  <script src="assets/js/counter.js"></script>
  <script src="assets/js/custom.js"></script>

  </body>
</html>
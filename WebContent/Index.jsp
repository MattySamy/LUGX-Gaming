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
java.net.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <title>Lugx Gaming</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-lugx-gaming.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    <link rel="stylesheet" href="assets/css/animate.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>
<!--

TemplateMo 589 lugx gaming

https://templatemo.com/tm-589-lugx-gaming

-->
  </head>

<body>

<%!
static String defaultNameSpace = "http://www.owl-ontologies.com/Ontology1702814107.owl#";

public Model Mod = null;

String game_name ,  game_genre , game_image, game_req;

ArrayList<String> name_list = new ArrayList<String>();
ArrayList<String> genre_list = new ArrayList<String>();
ArrayList<String> image_list = new ArrayList<String>();
ArrayList<String> game_list = new ArrayList<String>();
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
		RDFNode game  = soln.get("?game");
		
		if(name != null || genre != null || img != null){
			
		
			// set name
			game_name= name.toString();
			game_name=game_name.substring(0,game_name.indexOf('@'));                   //price
			name_list.add(count, game_name);
			
			// set genre
			game_genre= genre.toString();
			game_genre=game_genre.substring(53,game_genre.length());
			genre_list.add(count, game_genre);
			
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
                    <a href="index.jsp" class="logo">
                        <img src="assets/images/logo.png" alt="" style="width: 158px;">
                    </a>
                    <!-- ***** Logo End ***** -->
                    <!-- ***** Menu Start ***** -->
                    <ul class="nav">
                      <li><a href="Index.jsp" class="active">Home</a></li>
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

  <div class="main-banner">
    <div class="container">
      <div class="row">
        <div class="col-lg-6 align-self-center">
          <div class="caption header-text">
            <h6>Welcome to LUGX</h6>
            <h2>BEST GAMING SITE EVER!</h2>
            <p>LUGX Gaming is the Greatest web application to discover and download games which you like :)</p>
            <div class="search-input">
              <form id="search" action="#" onsubmit="searchGame(); return false;">
   				<input type="text" placeholder="Type Something..." id="searchText" name="searchKeyword" />
    			<button type="submit">Search Now</button>
			  </form>
            </div>
          </div>
        </div>
        <div class="col-lg-4 offset-lg-2">
          <div class="right-image">
            <img src="assets/images/banner-image.jpg" alt="">
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="features">
    <div class="container">
      <div class="row">
        <div class="col-lg-3 col-md-6">
          <a href="#">
            <div class="item">
              <div class="image">
                <img src="assets/images/featured-01.png" alt="">
              </div>
              <h4>Free Download</h4>
            </div>
          </a>
        </div>
        <div class="col-lg-3 col-md-6">
          <a href="#">
            <div class="item">
              <div class="image">
                <img src="./assets/images/featured-02.png" alt="">
              </div>
              <h4>User More</h4>
            </div>
          </a>
        </div>
        <div class="col-lg-3 col-md-6">
          <a href="#">
            <div class="item">
              <div class="image">
                <img src="./assets/images/featured-03.png" alt="" style="max-width: 85px;">
              </div>
              <h4>Reply Ready</h4>
            </div>
          </a>
        </div>
        <div class="col-lg-3 col-md-6">
          <a href="#">
            <div class="item">
              <div class="image">
                <img src="assets/images/featured-04.png" alt="" style="max-width: 90px;">
              </div>
              <h4>Easy Layout</h4>
            </div>
          </a>
        </div>
      </div>
    </div>
  </div>

  <div class="section trending">
    <div class="container">
      <div class="row">
        <div class="col-lg-6">
          <div class="section-heading">
            <h6>Trending</h6>
            <h2>Trending Games</h2>
          </div>
        </div>
        <div class="col-lg-6">
          <div class="main-button">
            <a href="games.jsp">View All</a>
          </div>
        </div>
<%
LoadOntology();
//Query
runQuery("SELECT ?game ?name ?genre ?image WHERE { ?game game:game_name ?name. ?game game:best_seller true. ?game game:IsGenreOf ?genre. ?game game:image ?image } LIMIT 8", Mod);
%>
        
        <%
        for(int e=0 ; e<count ; e++){
        	if(!("Adventure".equalsIgnoreCase(genre_list.get(e)) || "Simulation".equalsIgnoreCase(genre_list.get(e)) || "Strategy".equalsIgnoreCase(genre_list.get(e)) || "FPS".equalsIgnoreCase(genre_list.get(e)))){
            %>
            
              <div class="col-lg-3 col-md-6">
          <div class="item">
            <div class="thumb">
             <a href="game-details.jsp"><img src="<%= "assets" + "/" + (image_list.get(e).contains(".jpg") ? image_list.get(e) : image_list.get(e) + ".jpg") %>" alt="<%= image_list.get(e) %>"></a>
            </div>
            <div class="down-content">
              <span class="category"><%= genre_list.get(e) %></span>
              <h4><%= name_list.get(e) %></h4>
              <a href="<%= "game-details.jsp" + "?gameName=" + game_list.get(e) %>"><i class="fa fa-download" style="max-width: 20px;padding-top: 10px;"></i></a>
            </div>
          </div>
        </div>
        <% }
        }
        %>
      
      </div>
    </div>
  </div>

  <div class="section most-played">
    <div class="container">
      <div class="row">
        <div class="col-lg-6">
          <div class="section-heading">
            <h6>TOP GAMES</h6>
            <h2>Most Played</h2>
          </div>
        </div>
        <div class="col-lg-6">
          <div class="main-button">
            <a href="games.jsp">View All</a>
          </div>
        </div>
        
<%
LoadOntology();
//Query
runQuery("SELECT ?game ?name ?genre ?image WHERE { ?game game:game_name ?name. ?game game:best_seller true. ?game game:IsGenreOf ?genre. ?game game:image ?image. ?game game:IsMultiplayer true } ORDER BY ?game LIMIT 12", Mod);
%>
        
        <%
        for(int e=0 ; e<count ; e++){
        	if(!("Adventure".equalsIgnoreCase(genre_list.get(e)) || "Simulation".equalsIgnoreCase(genre_list.get(e)) || "Strategy".equalsIgnoreCase(genre_list.get(e)) || "FPS".equalsIgnoreCase(genre_list.get(e)))){
            %>
            
            <div class="col-lg-2 col-md-6 col-sm-6">
          <div class="item">
            <div class="thumb">
             <a href="game-details.jsp"><img src="<%= "assets" + "/" + (image_list.get(e).contains(".jpg") ? image_list.get(e) : image_list.get(e) + ".jpg") %>" alt="<%= image_list.get(e) %>"></a>
            </div>
            <div class="down-content">
                <span class="category"><%= genre_list.get(e) %></span>
              <h4><%= name_list.get(e) %></h4>
                <a href="<%= "game-details.jsp" + "?gameName=" + game_list.get(e) %>">Explore</a>
            </div>
          </div>
        </div>
        <% }
        }
        %>
      
      
      
      
      
      </div>
    </div>
  </div>

  <div class="section categories">
    <div class="container">
      <div class="row">
        <div class="col-lg-12 text-center">
          <div class="section-heading">
            <h6>Categories</h6>
            <h2>Top Categories</h2>
          </div>
        </div>
        
 <%
LoadOntology();
// Query
runQuery("SELECT DISTINCT ?game ?name ?genre ?image WHERE { ?game game:game_name ?name. ?game game:best_seller true. ?game game:IsGenreOf ?genre. ?game game:image ?image. ?game game:IsMultiplayer true} ORDER BY ?genre LIMIT 14", Mod);
%>

<%
List<String> processedGenres = new ArrayList<>();

for (int e = 0; e < count; e++) {
    String currentGenre = genre_list.get(e);

    // Check if the genre has not been processed already
    if (!processedGenres.contains(currentGenre)) {
        processedGenres.add(currentGenre);
        %>

        <div class="col-lg col-sm-6 col-xs-12">
            <div class="item">
                <h4><%= currentGenre %></h4>
                <div class="thumb">
                    <!-- Add your content here for each genre -->
                </div>
            </div>
        </div>

        <%
    }
}
%>




      
      
      </div>
    </div>
  </div>
  
  <div class="section cta">
    <div class="container">
      <div class="row">
        <div class="col-lg-5">
          <div class="shop">
            <div class="row">
              <div class="col-lg-12">
                <div class="section-heading">
                  <h6>Our Shop</h6>
                  <h2>Go Pre-Order Buy & Get Best <em>Prices</em> For You!</h2>
                </div>
                <p>Lorem ipsum dolor consectetur adipiscing, sed do eiusmod tempor incididunt.</p>
                <div class="main-button">
                  <a href="games.jsp">Play Now</a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-5 offset-lg-2 align-self-end">
          <div class="subscribe">
            <div class="row">
              <div class="col-lg-12">
                <div class="section-heading">
                  <h6>NEWSLETTER</h6>
                  <h2>Get Up To $100 Off Just Buy <em>Subscribe</em> Newsletter!</h2>
                </div>
                <div class="search-input">
                  <form id="subscribe" action="#">
                    <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Your email...">
                    <button type="submit">Subscribe Now</button>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <footer>
    <div class="container">
      <div class="col-lg-12">
        <p>Copyright © 2048 LUGX Gaming Company. All rights reserved. &nbsp;&nbsp; <a rel="nofollow" href="https://templatemo.com" target="_blank">Design: TemplateMo</a></p>
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
	<script>
    function searchGame() {
        // Implement the search function to handle the redirection
     var searchKeyword = document.getElementById('searchText').value;
     window.location.href = 'http://localhost:8080/JSP_SW/game-details.jsp?gameName=' + encodeURIComponent(searchKeyword);
   }
</script>
  </body>
</html>
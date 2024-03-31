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

    <title>Lugx Gaming - Games Page</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/templatemo-lugx-gaming.css">
    <link rel="stylesheet" href="assets/css/owl.css">
    <link rel="stylesheet" href="assets/css/animate.css">
    <link rel="stylesheet"href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>
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
//ArrayList<String> platform_list = new ArrayList<String>();
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
			
			
			// set genre
			//game_platform= platform.toString();
		    //game_platform=game_platform.substring(53,game_platform.length());
			//platform_list.add(count, game_platform);
			
			// set image
			game_image = img.toString();
			game_image = game_image.substring(0,game_image.indexOf('@'));
			image_list.add(count, game_image);
			
			//set game
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
                      <li><a href="games.jsp" class="active">Games</a></li>
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

  <div class="page-heading header-text">
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <h3>Games</h3>
          <span class="breadcrumb"><a href="Index.jsp">Home</a> > Games</span>
        </div>
      </div>
    </div>
  </div>

  <div class="section trending">
    <div class="container">
    <h1 align="center">Platforms</h1>
      <ul class="trending-filter">
        <li>
          <a class="is_active" href="#!" data-filter="*">Show All</a>
        </li>
        <li>
          <a href="#!" data-filter=".pc">PC</a>
        </li>
        <li>
          <a href="#!" data-filter=".ps">PS</a>
        </li>
        <li>
          <a href="#!" data-filter=".nin">Nintendo Switch</a>
        </li>
      </ul>
      
      
          <%
LoadOntology();
//Query
runQuery("SELECT DISTINCT ?game ?name ?genre ?image WHERE { ?game game:game_name ?name. ?game game:hasPlatform game:PC. ?game game:IsGenreOf ?genre. ?game game:image ?image }", Mod);
%>

        <%
        for(int e=0 ; e<count ; e++){
        	String currentGenre =genre_list.get(e);
        	if(!("Adventure".equalsIgnoreCase(currentGenre) || "Simulation".equalsIgnoreCase(currentGenre) || "Strategy".equalsIgnoreCase(currentGenre) || "FPS".equalsIgnoreCase(currentGenre))){
            %>
      <div class="row trending-box">  
         <div class="col-lg-3 col-md-6 align-self-center mb-30 trending-items col-md-6
            <%= currentGenre.equals("Action") ? "pc" : "" %>
            <%= currentGenre.equals("Puzzle") ? "pc" : "" %>
            <%= currentGenre.equals("Horror") ? "pc" : "" %>
             <%= currentGenre.equals("Sports") ? "pc" : "" %>">
          <div class="item">
            <div class="thumb">
             <a href="game-details.jsp"><img src="<%= "assets" + "/" + (image_list.get(e).contains(".jpg") ? image_list.get(e) : image_list.get(e) + ".jpg") %>" alt="<%= image_list.get(e) %>"></a>
            </div>
            <div class="down-content">
                <span class="category"><%= currentGenre %></span>
              <h4><%= name_list.get(e) %></h4>
                <a href="<%= "game-details.jsp" + "?gameName=" + game_list.get(e) %>"><i class="fa fa-download" style="max-width: 20px;padding-top: 10px;"></i></a>
            </div>
          </div>
        </div>

        <% }
        }
        %>
   	
   	        <%
LoadOntology();
//Query
runQuery("SELECT DISTINCT ?game ?name ?genre ?image WHERE { ?game game:game_name ?name. ?game game:hasPlatform game:PS. ?game game:IsGenreOf ?genre. ?game game:image ?image }", Mod);
%>

        <%
        for(int e=0 ; e<count ; e++){
        	String currentGenre =genre_list.get(e);
        	if(!("Adventure".equalsIgnoreCase(currentGenre) || "Simulation".equalsIgnoreCase(currentGenre) || "Strategy".equalsIgnoreCase(currentGenre) || "FPS".equalsIgnoreCase(currentGenre))){
            %>
      <div class="row trending-box">  
         <div class="col-lg-3 col-md-6 align-self-center mb-30 trending-items col-md-6
            <%= currentGenre.equals("Action") ? "ps" : "" %>
            <%= currentGenre.equals("Puzzle") ? "ps" : "" %>
            <%= currentGenre.equals("Horror") ? "ps" : "" %>
             <%= currentGenre.equals("Sports") ? "ps" : "" %>">
          <div class="item">
            <div class="thumb">
             <a href="game-details.jsp"><img src="<%= "assets" + "/" + (image_list.get(e).contains(".jpg") ? image_list.get(e) : image_list.get(e) + ".jpg") %>" alt="<%= image_list.get(e) %>"></a>
            </div>
            <div class="down-content">
                <span class="category"><%= currentGenre %></span>
              <h4><%= name_list.get(e) %></h4>
                <a href="<%= "game-details.jsp" + "?gameName=" + game_list.get(e) %>"><i class="fa fa-download" style="max-width: 20px;padding-top: 10px;"></i></a>
            </div>
          </div>
        </div>

        <% }
        }
        %>
   	
   	        <%
LoadOntology();
//Query
runQuery("SELECT DISTINCT ?game ?name ?genre ?image WHERE { ?game game:game_name ?name. ?game game:hasPlatform game:Nintendo. ?game game:IsGenreOf ?genre. ?game game:image ?image }", Mod);
%>

        <%
        for(int e=0 ; e<count ; e++){
        	String currentGenre =genre_list.get(e);
        	if(!("Adventure".equalsIgnoreCase(currentGenre) || "Simulation".equalsIgnoreCase(currentGenre) || "Strategy".equalsIgnoreCase(currentGenre) || "FPS".equalsIgnoreCase(currentGenre))){
            %>
      <div class="row trending-box">  
         <div class="col-lg-3 col-md-6 align-self-center mb-30 trending-items col-md-6
            <%= currentGenre.equals("Action") ? "nin" : "" %>
            <%= currentGenre.equals("Puzzle") ? "nin" : "" %>
            <%= currentGenre.equals("Horror") ? "nin" : "" %>
             <%= currentGenre.equals("Sports") ? "nin" : "" %>">
          <div class="item">
            <div class="thumb">
             <a href="game-details.jsp"><img src="<%= "assets" + "/" + (image_list.get(e).contains(".jpg") ? image_list.get(e) : image_list.get(e) + ".jpg") %>" alt="<%= image_list.get(e) %>"></a>
            </div>
            <div class="down-content">
                <span class="category"><%= currentGenre %></span>
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
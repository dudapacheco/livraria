<%@page import="modelo.Autor"%>
<%@page import="dao.AutorDAO"%>
<%@page import="util.StormData"%>
<%@page import="modelo.Editora"%>
<%@page import="dao.EditoraDAO"%>
<%@page import="modelo.Categoria"%>
<%@page import="dao.CategoriaDAO"%>
<%@page import="dao.LivroDAO"%>
<%@page import="modelo.Livro"%>
<%@page import="java.util.List"%>

<%@include file="../cabecalho.jsp" %>
<%
    String msg = "";
    String classe = "";
    AutorDAO adao = new AutorDAO();
    if(request.getMethod().equals("POST")){
        //pego uma lista de autores(com mesmo name)
        String[] autoresid = request.getParameterValues("autores");
        //popular o livro
        Livro l = new Livro();
        l.setNome("StorTroopers - Uma viagem que nao sai");
        l.setDatapublicacao(new Date());
        l.setPreco(13.12f);
        //Autores
        List<Autor> listaautores = new ArrayList<>();
        for (String id : autoresid) {
            Integer idinteger = Integer.parseInt(id);
            listaautores.add(adao.buscarPorChavePrimaria(idinteger));
         }
        l.setAutorList(listaautores);
        
        LivroDAO dao = new LivroDAO();
        dao.incluir(l);
    }
    
    
    //pego meus autores
  
    List<Autor> autores = adao.listar();
    
    Livro obj = new Livro();
    LivroDAO dao = new LivroDAO();
    
    CategoriaDAO cdao = new CategoriaDAO();
    Categoria clista = new Categoria();
    Categoria c = new Categoria();
   
    EditoraDAO edao = new EditoraDAO();
    Editora elista = new Editora();
    Editora e = new Editora();
    
        
    if(request.getParameter("txtNome") != null && request.getParameter("txtPreco") !=  null && request.getParameter("txtData") != null && request.getParameter("txtSinopse") != null && request.getParameter("txtCategoria") != null && request.getParameter("txtEditora") != null ){
        
        obj.setNome(request.getParameter("txtNome"));
        obj.setPreco(Float.parseFloat(request.getParameter("txtPreco")));
        obj.setDatapublicacao(StormData.formata(request.getParameter("txtData")));
        obj.setImagem1(request.getParameter("txtFotoLivro1"));
        obj.setImagem2(request.getParameter("txtFotoLivro2"));
        obj.setImagem3(request.getParameter("txtFotoLivro3"));
        obj.setSinopse(request.getParameter("txtSinopse"));
        c.setId(Integer.parseInt(request.getParameter("txtCategoria")));
        e.setCnpj(request.getParameter("txtEditora"));
        
    
        Boolean resultado = dao.incluir(obj);
        dao.fecharConexao();
        if (resultado) {
            msg = "Registro cadastrado com sucesso";
            classe = "alert-success";
        } else {
            msg = "N�o foi poss�vel cadastrar";
            classe = "alert-danger";
        }
     
    }
   
 
    
%>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
            Sistema de Com�rcio Eletr�nico
            <small>Admin</small>
        </h1>
        <ol class="breadcrumb">
            <li>
                <i class="fa fa-dashboard"></i>  <a href="index.jsp">�rea Administrativa</a>
            </li>
            <li class="active">
                <i class="fa fa-file"></i> Aqui vai o conte�do de apresenta��o 
            </li>
        </ol>
    </div>
</div>
<!-- /.row -->
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
            Livros
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>">
                <%=msg%>
            </div>
            <form action="../UploadWS" method="post" enctype="multipart/form-data">

                <div class="col-lg-6">

                    <div class="form-group">
                        <label>Nome</label>
                        <input class="form-control" type="text"  name="txtNome"  required />
                    </div>
                    <div class="form-group">
                        <label>Pre�o</label>
                        <input class="form-control" type="text"  name="txtPreco"  required />
                        
                    </div>
                    <div class="form-group">
                        <label>Data da publica��o</label>
                        <input class="form-control" type="text"  name="txtData"  required />
                    </div>
                    <div class="form-group">
                        <label>Foto 1</label>
                        <input class="form-control" type="file"  name="txtFotoLivro1"  required />
                    </div>
                    <div class="form-group">
                        <label>Foto 2</label>
                        <input class="form-control" type="file"  name="txtFotoLivro2"  required />
                    </div>
                    <div class="form-group">
                        <label>Foto 3</label>
                        <input class="form-control" type="file"  name="txtFotoLivro3"  required />
                    </div>
                    <div class="form-group">
                        <label>Sinopse</label>
                        <input class="form-control" type="text"  name="txtSinopse"  required />
                    </div>
                    <div class="form-group">
                        <label>Categoria:</label>
                        <select name =" txtCategoria" required/>
                        <%
                            for(Categoria item : clista){
                            
                            %>
                            <option value ="<%=item.getId()%>">
                                <%=item.getNome()%>
                            </option>
                            <%
                                }
                            %>
                    </div>
                    <div class="form-group">
                        <label>Editora</label>
                        <select name =" txtEditora" required/>

                        <%
                            for(Editora it : elista){
                            
                            %>
                            <option value ="<%=it.getCnpj()%>">
                                <%=it.getNome()%>
                            </option>
                            <%
                                }
                            %>
                    </div>
                    <div class="form-group">
                        <label>Autor</label>
                        <input class="form-control" type="text"  name="txt Autor"  required />
                    </div>
                    

                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>

            </form>

        </div>


    </div>
</div>
<!-- 1/.row -->
<%@include file="../rodape.jsp" %>
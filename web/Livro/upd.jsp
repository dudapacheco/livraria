<%@page import="java.util.ArrayList"%>
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
    Autor a = new Autor();
    //pego meus autores
  
    List<Autor> autores = adao.listar();
    
    Livro obj = new Livro();
    LivroDAO dao = new LivroDAO();
    
    CategoriaDAO cdao = new CategoriaDAO();
    Categoria c = new Categoria();
    List<Categoria> clista = cdao.listar();
    
   
    EditoraDAO edao = new EditoraDAO();
    Editora e = new Editora();
    List<Editora> elista = edao.listar();
    
    if(request.getMethod().equals("POST")){
        //pego uma lista de autores(com mesmo name)
        String[] autoresid = request.getParameter("txtAutor").split(";");
        //popular o livro
        
    
        
        obj.setNome(request.getParameter("txtNome"));
        obj.setPreco(Float.parseFloat(request.getParameter("txtPreco")));
        obj.setDatapublicacao(StormData.formata(request.getParameter("txtData")));
        obj.setImagem1(request.getParameter("txtFotoLivro1"));
        obj.setImagem2(request.getParameter("txtFotoLivro2"));
        obj.setImagem3(request.getParameter("txtFotoLivro3"));
        obj.setSinopse(request.getParameter("txtSinopse"));
        c.setId(Integer.parseInt(request.getParameter("txtCategoria")));
        e.setCnpj(request.getParameter("txtEditora"));
        a.setId(Integer.parseInt("txtAutor"));
        obj.setCategoria(c);
        obj.setEditora(e);
        
        
    //Autores
            List<Autor> listaautores = new ArrayList<>();
            for (String id : autoresid) {
                Integer idinteger = Integer.parseInt(id);
                listaautores.add(adao.buscarPorChavePrimaria(idinteger));
            }
            obj.setAutorList(listaautores);
            
            
            Boolean resultado = dao.alterar(obj);
        dao.fecharConexao();
        if (resultado) {
            msg = "Registro cadastrado com sucesso";
            classe = "alert-success";
        } else {
            msg = "Não foi possível cadastrar";
            classe = "alert-danger";
        }
        
        
    }
    else{
        //e GET
        if(request.getParameter("codigo") == null){
            response.sendRedirect("index.jsp");
            return;
        }
        
        dao = new LivroDAO();
        obj = dao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("codigo")));
        
        
        if(obj == null){
            response.sendRedirect("index.jsp");
            return;
        } 
    }
          


    
%>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
            Sistema de Comércio Eletrônico
            <small>Admin</small>
        </h1>
        <ol class="breadcrumb">
            <li>
                <i class="fa fa-dashboard"></i>  <a href="index.jsp">Área Administrativa</a>
            </li>
            <li class="active">
                <i class="fa fa-file"></i> Aqui vai o conteúdo de apresentação 
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
                        <input class="form-control" type="text"  name="txtNome"  required value="<%=obj.getNome()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Preço</label>
                        <input class="form-control" type="text"  name="txtPreco"  required value="<%=obj.getPreco()%>" />
                        
                    </div>
                    <div class="form-group">
                        <label>Data da publicação</label>
                        <input class="form-control" type="text"  name="txtData"  required value="<%=obj.getDatapublicacao()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Foto 1</label>
                        <input class="form-control" type="file"  name="txtFotoLivro1"  required value="<%=obj.getImagem1()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Foto 2</label>
                        <input class="form-control" type="file"  name="txtFotoLivro2"  required value="<%=obj.getImagem2()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Foto 3</label>
                        <input class="form-control" type="file"  name="txtFotoLivro3"  required value="<%=obj.getImagem3()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Sinopse</label>
                        <input class="form-control" type="text"  name="txtSinopse"  required value="<%=obj.getSinopse()%>"/>
                    </div>
                   <div class="form-group">
                        <label>Categoria:</label>
                        <select name ="txtCategoria" required>
                        <%
                            for(Categoria item : clista){
                            
                            %>
                            <option value ="<%=item.getId()%>">
                                <%=item.getNome()%>
                            </option>
                            <%
                                }
                            %>
                            
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Editora</label>
                        <select name="txtEditora" required>

                        <%
                            for(Editora item : elista){
                            
                            %>
                            <option value ="<%=item.getCnpj()%>">
                                <%=item.getNome()%>
                            </option>
                            <%
                                }
                            %>
                    </select>
                    </div>
                    <div class="form-group">
                        <label>Autor</label>
                        <%
                            for(Autor item : autores){
                        %>
                        <input class="form-control" type="checkbox"  name="txtAutor"  required value="<%=item.getId()%>"><%=item.getNome()%>
                        <%}%>
                    </div>
                    
                    

                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>

            </form>

        </div>


    </div>
</div>
<!-- 1/.row -->
<%@include file="../rodape.jsp" %>
<%@page import="dao.LivroDAO"%>
<%@page import="modelo.Livro"%>
<%@page import="java.util.List"%>

<%@include file="../cabecalho.jsp" %>
<%
    String msg = "";
    String classe = "";
    Livro obj = new Livro();
    LivroDAO dao = new LivroDAO();
    
    if (request.getParameter("txtNome") != null && 
        request.getParameter("txtSexo") != null && request.getParameter("txtNacionalidade") != null && request.getParameter("txtFotoLivro") != null) {
        obj.setNome(request.getParameter("txtNome"));
        obj.setSexo(request.getParameter("txtSexo").charAt(0));
        obj.setNacionalidade(request.getParameter("txtNacionalidade"));
        obj.setFoto(request.getParameter("txtFotoLivro"));
        
        Boolean resultado = dao.incluir(obj);
        if (resultado) {
            msg = "Registro cadastrado com sucesso";
            classe = "alert-success";
        } else {
            msg = "Não foi possível cadastrar";
            classe = "alert-danger";
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
                        <input class="form-control" type="text"  name="txtNome"  required />
                    </div>
                    <div class="form-group">
                        <label>Preço</label>
                        <input class="form-control" type="text"  name="txtPreco"  required />
                        
                    </div>
                    <div class="form-group">
                        <label>Data da publicação</label>
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
                        <label>Categoria</label>
                        <input class="form-control" type="text"  name="txtCategoria"  required />
                    </div>
                    <div class="form-group">
                        <label>Editora</label>
                        <input class="form-control" type="text"  name="txtEditora"  required />
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
<%@page import="dao.EditoraDAO"%>
<%@page import="modelo.Editora"%>
<%@page import="java.util.List"%>

<%@include file="../cabecalho.jsp" %>
<%
    String msg = "";
    String classe = "";
    Editora obj = new Editora();
    EditoraDAO dao = new EditoraDAO();
    
    if (request.getParameter("txtNome") != null) {
        obj.setNome(request.getParameter("txtNome"));
        
     if (request.getParameter("txtFoto") != null) {
        obj.setLogo(request.getParameter("txtFoto"));
        
     if (request.getParameter("txtLivro") != null) {
        obj.setLivroList(request.getParameter("txtLivro"));
        
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
            Editoras
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>">
                <%=msg%>
            </div>
            <form action="UploadWS" method="post" enctype="multiparti/form-data">

                <div class="col-lg-6">

                    <div class="form-group">
                        <label>Nome</label>
                        <input class="form-control" type="text"  name="txtNome"  required />
                    </div>
                    <div class="form-group">
                        <label>Logotipo</label>
                        
                        <input class="form-control" type="file"  name="txtFoto"  required />
                    </div>
                    <div class="form-group">
                        <label>Livro</label>
                        <input class="form-control" type="text"  name="txtLivro "  required />
                    </div>

                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>

            </form>

        </div>


    </div>
</div>
<!-- 1/.row -->
<%@include file="../rodape.jsp" %>
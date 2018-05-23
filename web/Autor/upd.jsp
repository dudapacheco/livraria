
<%@page import="java.math.BigDecimal"%>
<%@page import="modelo.Autor"%>
<%@page import="dao.AutorDAO"%>
<%@include file="../cabecalho.jsp" %>
<%
String msg ="";
String classe = "";
    
AutorDAO dao = new AutorDAO();
Autor obj = new Autor();
    //verifica se � postm ou seja, quer alterar
    if(request.getMethod().equals("POST")){
        
        //popular com oq ele digitou no form
        obj.setId(Integer.parseInt(request.getParameter("txtCodigo")));
        obj.setNome(request.getParameter("txtNome"));
        obj.setSexo(request.getParameter("txtSexo").charAt(0));
        obj.setNacionalidade(request.getParameter("txtNacionalidade"));
        if(request.getParameter("txtFoto") != null)
        {
            obj.setFoto(request.getParameter("txtFoto"));
            
        }
        else{
            
            obj.setFoto(request.getParameter("txtFotoVelha"));
        }
        
        
        Boolean resultado = dao.alterar(obj);
        
        if(resultado){
            msg = "Registro alterado com sucesso";
            classe = "alert-success";
        }
        else{
            msg = "N�o foi poss�vel alterar";
            classe = "alert-danger";
        }
        
    }else{
        //e GET
        if(request.getParameter("codigo") == null){
            response.sendRedirect("index.jsp");
            return;
        }
        
        dao = new AutorDAO();
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
        Autor
        </div>
        <div class="panel-body">

            <div class="alert <%=classe%>">
                <%=msg%>
            </div>
            <form action="../UploadWS" method="post" enctype = "multipart/form-data">
                
                <div class="col-lg-6">

                    <div class="form-group">
                        <label>C�digo</label>
                        <input class="form-control" type="text" name="txtCodigo" readonly value="<%=obj.getId()%>"/>
                    </div>
                    
                    <div class="form-group">
                        <label>Nome</label>
                        <input class="form-control" type="text" name="txtNome" required value="<%=obj.getNome() %>" />
                    </div>
                    
                    <div class="form-group">
                        <label>Sexo</label>
                        <select name="txtSexo" required value= <%=obj.getSexo()%> >
                            <option value = "M">Masculino</option>
                            <option value ="F"> Feminino</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Nacionalidade</label>
                        <input class="form-control" type="text" name="txtNacionalidade" required value="<%=obj.getNacionalidade()%>" />
                    </div
                    
                     <div class="form-group">
                        <label>Foto</label>
                       <input class="form-control" type="file" name="txtFoto" id="arquivo1"  accept="image/*" />
                       <img src="../arquivos/<%=obj.getFoto()%>" id="img1"/>
                       <input type="hidden" name="txtFotoVelha" value="<%=obj.getFoto()%>"/>
                    </div>
                  


                <button class="btn btn-primary btn-sm" type="submit">Salvar</button>
                
            </form>

        </div>


    </div>
</div>
<!-- /.row -->
<%@include file="../rodape.jsp" %>
    
    <script>
    function readURL(input,destino) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
                $('#'+destino).attr('src', e.target.result);
            }
            
            reader.readAsDataURL(input.files[0]);
        }
    }
    
    $("#txtFotoLivro1").change(function(){
        readURL(this,"img1");
    });
    </script>
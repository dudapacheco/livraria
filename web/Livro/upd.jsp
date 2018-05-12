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
    LivroDAO dao = new LivroDAO();
    CategoriaDAO cdao = new CategoriaDAO();
    AutorDAO adao = new AutorDAO();
    EditoraDAO edao = new EditoraDAO();
    
    
    Livro obj = new Livro();
    Categoria ct = new Categoria();
    Editora ed = new Editora();
    
    //verifica se é postm ou seja, quer alterar
    if (request.getMethod().equals("POST")) {
      
        obj.setNome(request.getParameter("txtNome"));
        obj.setPreco(Float.parseFloat(request.getParameter("txtPreco")));
        obj.setDatapublicacao(StormData.formata(request.getParameter("txtData")));
        obj.setImagem1(request.getParameter("txtFotoLivro1"));
        obj.setImagem2(request.getParameter("txtFotoLivro2"));
        obj.setImagem3(request.getParameter("txtFotoLivro3"));
        obj.setSinopse(request.getParameter("txtSinopse"));
        ct.setId(Integer.parseInt(request.getParameter("selCategoria")));
        ed.setCnpj(request.getParameter("selEditora"));
        obj.setCategoria(ct);
        obj.setEditora(ed);
        
        Boolean resultado = dao.alterar(obj);
        
        if(resultado){
            msg = "Registro alterado com sucesso";
            classe = "alert-success";
        }
        else{
            msg = "Não foi possível alterar";
            classe = "alert-danger";
        }

    } else {
        //e GET
        if (request.getParameter("codigo") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        
        obj = dao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("codigo")));

        if (obj == null) {
            response.sendRedirect("index.jsp");
            return;
        }
    }

    List<Autor> autores = adao.listar();
    List<Editora> editoras = edao.listar();
    List<Categoria> categorias = cdao.listar();


    
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
                        <input class="form-control" type="text"  name="txtData"  required value="<%=StormData.formata(obj.getDatapublicacao())%>"/>
                    </div>
                    <div class="form-group">
                        <label>Foto 1</label>
                        <input class="form-control" type="file" name="txtFotoLivro1" id="arquivo1"  accept="image/*" />
                        <img src="../arquivos/<%=obj.getImagem1()%>" id="img1"/>
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
                        <textarea class="form-control"  name="txtSinopse"><%=obj.getSinopse()%>
                        </textarea>
                    </div>
                   <div class="form-group">
                        <label>Categoria:</label>
                        <select name="selCategoria" class="form-control">
                            <option>Selecione</option>
                        <%
                         String selecionado;
                         for(Categoria c:categorias){
                             
                            if(obj.getCategoria().getId()==c.getId()){
                                selecionado="selected";
                            }
                            else{
                                selecionado="";
                            }
                        %>
                        <option value="<%=c.getId()%>" <%=selecionado%>>
                            
                            
                        <%=c.getNome()%>
                        </option>
                        <%}%>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Editora</label>
                       <select name="selEditora" class="form-control">
                            <option>Selecione</option>
                        <%
                         String sel;
                         for(Editora e:editoras){
                             
                            if(obj.getEditora().getCnpj()==e.getCnpj()){
                                selecionado="selected";
                            }
                            else{
                                selecionado="";
                            }
                        %>
                        <option value="<%=e.getCnpj()%>" <%=selecionado%>>
                            
                            
                        <%=e.getNome()%>
                        </option>
                        <%}%>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Autor</label>
                       <%for (Autor a : autores) {
                           //verifica se o autor está na lista
                          if(obj.getAutorList().contains(a))
                          {
                              selecionado = "checked";
                          }
                          else{
                              selecionado = "";
                          }

                           %>
                        <input type="checkbox" name="autoreschk" <%=selecionado%> value="<%=a.getId()%>"><%=a.getNome()%>

                        <%}%>

                    </div>
                    
                    

                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>

            </form>

        </div>


    </div>
</div>
<!-- 1/.row -->
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
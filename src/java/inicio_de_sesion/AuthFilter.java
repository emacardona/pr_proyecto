
package inicio_de_sesion;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/menu.jsp") // Aplica este filtro a todas las páginas protegidas
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        // Inicialización del filtro si es necesario
    }

    /**
     *
     * @param request
     * @param response
     * @param chain
     * @throws IOException
     * @throws ServletException
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Verifica si hay una sesión activa con el atributo 'nombreUsuario'
        if (session == null || session.getAttribute("nombreUsuario") == null) {
            // Redirige al login si el usuario no está autenticado
            httpResponse.sendRedirect("index.jsp");
        } else {
            // Continúa con la solicitud si el usuario está autenticado
            chain.doFilter(request, response);
        }
    }

    public void destroy() {
        // Finalización del filtro si es necesario
    }
}

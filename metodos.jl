module Metodos
    export calc_x, dif_finitas

    function calc_x(delta_x, L)
        x = Float64[]

        for i in 0:delta_x:L
            append!(x, i)
        end

        return x
    end

    function dif_finitas(pvc)
        N = length(pvc.x)

        A = zeros(Float64, N-2, N-2)
        B = fill(pvc.h_linha*(pvc.delta_x^2)*pvc.t_inf, N-2)
        # primeiro
        A[1, 1] = 2 + pvc.h_linha*pvc.delta_x^2
        A[1, 2] = -1
        B[1] += pvc.t_a

        # ultimo
        A[N-2, N-3] = -1
        A[N-2, N-2] = 2 + pvc.h_linha*pvc.delta_x^2
        B[N-2] += pvc.t_b
        
        for i in 2:N-3
            A[i, i-1] = -1
            A[i, i] = (2 + pvc.h_linha * pvc.delta_x^2)
            A[i, i+1] = -1

            B[i] = pvc.h_linha*(pvc.delta_x^2)*pvc.t_inf
        end

        result = A\B
        
        insert!(result, 1, pvc.t_a)
        insert!(result, N, pvc.t_b)

        return result
    end
end
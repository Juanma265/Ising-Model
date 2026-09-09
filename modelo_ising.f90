program modelo_ising
    REAL :: T, r, dE, m
    REAL, DIMENSION(2) :: p
    INTEGER :: N, L, i, j, k, config, fil, col, limx_0, limx_N, limy_0, limy_N, sum
    INTEGER, ALLOCATABLE :: s(:,:) ! Memoria dinámica para la red de espines (depende de N)

    WRITE(*,*) "Side (LxL): "
    READ(*,*) L
    WRITE(*,*) "Temperatura: "
    READ(*,*) T
    WRITE(*,*) "Configuracion ordenada(1) o desordenada(2): "
    READ(*,*) config

    open (1, file="magnetizacion.txt", status="replace") ! Archivo para guardar la magnetización
    open (2, file="matriz_configuracion.txt", status="replace") ! Archivo para guardar la configuración de espines
    ALLOCATE(s(L,L))

    N = L * L ! Número total de espines en la red

    CALL RANDOM_SEED()

    ! Inicialización
    if (config == 1) then
        s = 1 !Configuración ordenada
    else
        DO i=1,L
            DO j=1,L
                CALL RANDOM_NUMBER(r)
                if (r < 0.5) then
                    s(i,j) = -1 !Configuración desordenada
                else
                    s(i,j) = 1
                end if
            END DO
        END DO
    end if


    write(2,*) s ! Guardar la configuración inicial en el archivo
     
   
    sum = 0

    do j=1,L
        do k=1,L
            sum = sum + s(j,k) ! Suma de los espines para calcular la magnetización inicial
        end do
    end do

    m = REAL(sum) / REAL(N) !m = M/N Magnetización por espín

    do i=1,100000000
        ! Seleccionar un espín aleatorio
        CALL RANDOM_NUMBER(p(1))
        CALL RANDOM_NUMBER(p(2))
        fil = INT(p(1) * L) + 1 ! Se añade 1 para evitar índice 0
        col = INT(p(2) * L) + 1 ! Se añade 1 para evitar índice 0

        !Condiciones de frontera periódicas

        limx_0 = fil -1
        limx_N = fil +1
        limy_0 = col -1
        limy_N = col +1

        if (limx_0 == 0)   limx_0 = L
        if (limx_N == L+1) limx_N = 1
        if (limy_0 == 0)   limy_0 = L
        if (limy_N == L+1) limy_N = 1

        dE = 2.0 * s(fil,col) * (s(limx_0,col) + s(limx_N,col) + s(fil,limy_0) + s(fil,limy_N))

        if (dE <= 0.0) then
            s(fil,col) = -s(fil,col) ! Aceptar el cambio
            sum = sum + 2 * s(fil,col) ! Actualizar la suma de espines
        else
            CALL RANDOM_NUMBER(r)
            if (r < EXP(-dE/T)) then
                s(fil,col) = -s(fil,col) ! Aceptar el cambio
                sum = sum + 2 * s(fil,col) ! Actualizar la suma de espines
            end if
        end if

       if (mod(i, N * 20) == 0) then
            write(2, '(A, I0)') "SIGUIENTE ", i
            do j=1, L
                write(2, '(1000I3)') (s(j, k), k=1, L)
            end do
        end if

        if (mod(i,1000) == 0) then !Guardar la magnetización cada 1000 iteraciones
            m = REAL(sum) / REAL(N) ! Actualizar la magnetización por espín
            write(1, *) i, m
        end if

    end do    

    close(1)
    close(2)
end program modelo_ising 
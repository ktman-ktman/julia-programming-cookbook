function allocator(n)
    zeros(n)
    zeros(n, n)
    zeros(n, n, n)
end

using Profile

allocator(1)
Profile.clear_malloc_data()
allocator(100)